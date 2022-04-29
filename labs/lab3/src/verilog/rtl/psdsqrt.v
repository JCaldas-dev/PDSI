module psdsqrt(
        input clock,
				input reset,
				input start,
				input stop,
				input [31:0] xin,
				output reg [15:0] sqrt
			  );

//reg signed [31:0] Q;
wire [15:0] aux;
wire [31:0] Q;

wire [31:0] sqtestsqrt;
wire [15:0] testsqrt;
reg [15:0] leftD;
reg [15:0] rightD;

reg [15:0] tempsqrt;
reg [15:0] rightQ;

always@(posedge clock)
begin
/*if(reset)
begin
  Q = 32'h0;
	sqrt <= 16'h0;
	tempsqrt <= 16'h0;
	rightQ <= 16'h0;
end
else
begin*/
	tempsqrt <= leftD;
	rightQ <= rightD;
end
//end

dff32 init(
		 .CLK(clock),
		 .en(start),
		 .reset(reset),
		 .Din(xin),
		 .Qout(Q)
		);

dff16 out(
		 .CLK(clock),
		 .en(stop),
		 .reset(reset),
		 .Din(tempsqrt),
		 .Qout(aux)
		);

assign sqtestsqrt = testsqrt * testsqrt;
assign testsqrt = tempsqrt | rightQ;

always @*
begin


if (start)
    leftD = 16'h0000;
else
begin
    if (Q >= (sqtestsqrt))
        leftD = testsqrt;
    else
        leftD = tempsqrt;
end

if (start)
    rightD = 16'h8000;
else
    rightD = rightQ >> 1;



sqrt = aux;
end

endmodule
