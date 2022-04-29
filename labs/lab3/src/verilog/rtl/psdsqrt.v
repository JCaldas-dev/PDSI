module psdsqrt(
        input clock,
				input reset,
				input start,
				input stop,
        input [5:0] NBITSIN,
				input [63:0] xin,
				output reg [31:0] sqrt
			  );

wire [31:0] aux;
wire [31:0] aux2;
wire [31:0] aux3;
wire [63:0] Q;
wire [63:0] sqtestsqrt;
wire [31:0] testsqrt;

reg [31:0] leftD;
reg [31:0] rightD;

reg [31:0] tempsqrt;
reg [31:0] rightQ;

always@(posedge clock)
begin
if(reset)
begin
	tempsqrt <= 32'h0;
	rightQ <= 32'h0;
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
assign aux2 = 32'h1<<(NBITSIN/2-1);
assign aux3 = (32'h1<<NBITSIN) -1;

always @*
begin


if (start)
    leftD = 32'h0;
else
begin
    if (Q  >= (sqtestsqrt))
        leftD = testsqrt;
    else
        leftD = tempsqrt;
end

if (start)
begin
    rightD <= aux2;
end
else
    rightD = rightQ >> 1;

sqrt = aux;

end

endmodule
