module psdsqrt
      #(parameter NBITSIN = 32) (
        input clock,
				input reset,
				input start,
				input stop,
				input [NBITSIN-1:0] xin,
				output reg [NBITSIN/2-1:0] sqrt
			  );

wire [NBITSIN/2-1:0] aux;
wire [NBITSIN/2-1:0] aux2;
wire [NBITSIN/2-1:0] aux3;
wire [NBITSIN-1:0] Q;
wire [NBITSIN-1:0] sqtestsqrt;
wire [NBITSIN/2-1:0] testsqrt;

reg [NBITSIN/2-1:0] leftD;
reg [NBITSIN/2-1:0] rightD;

reg [NBITSIN/2-1:0] tempsqrt;
reg [NBITSIN/2-1:0] rightQ;

always@(posedge clock)
begin
if(reset)
begin
	tempsqrt <= NBITSIN/2'h0;
	rightQ <= NBITSIN/2'h0;
end
else
begin
	tempsqrt <= leftD;
	rightQ <= rightD;
end
end

dff64 init(
		 .CLK(clock),
		 .en(start),
		 .reset(reset),
		 .Din(xin & aux3),
		 .Qout(Q)
		);

dff32 out(
		 .CLK(clock),
		 .en(stop),
		 .reset(reset),
		 .Din(tempsqrt),
		 .Qout(aux)
		);

assign sqtestsqrt = testsqrt * testsqrt;
assign testsqrt = tempsqrt | rightQ;
assign aux2 = NBITSIN/2'h1<<(NBITSIN/2-1);
assign aux3 = (NBITSIN/2-1'h1<<NBITSIN) -1;

always @*
begin


if (start)
    leftD = NBITSIN/2-1'h0;
else
begin
    if (Q  >= (sqtestsqrt))
        leftD = testsqrt;
    else
        leftD = tempsqrt;
end

if (start)
begin
    rightD = aux2;
end
else
    rightD = rightQ >> 1;

sqrt = aux;

end

endmodule
