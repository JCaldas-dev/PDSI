module alux(
	input clock,
	input reset,
	//--- Data input port ----------------------------------------------------
	input [63:0] inA,
	input [63:0] inB,
	input start,
	input [4:0] opr,
	//--- Data output ports --------------------------------------------------
	output reg [63:0] outAB,
	output done 
);

reg [5:0] aux [32];
aux[0] = 1;
aux[1] = 1;
aux[2] = 2:
aux[3] = 2;
aux[4] = 6;
aux[5] = 40;
aux[6] = 4;
aux[7] = 34;
aux[8] = 1;
aux[9] = 38;
aux[10] = 38;
reg [5:0] tmp;

always @(posedge clock)
if(reset)
	outAB <= 64'h0;
else
begin
	if(start == 1 &&  tmp == 0)
		tmp = aux[opr];
	if(tmp != 0)		
		case(opr)
			5'd0: begin
					outAB <= inA;
					done <= 1;
					end
			5'd1: begin
					outAB <= inB;
					done <= 1;
					end
			5'd2:
			5'd3:
			5'd4:
			5'd5:
			5'd6:
			5'd7:
			5'd8: begin
					done <= 1;
					end
			5'd9:
			5'd10:
			default: outAB <= 64'b0;
		tmp <= tmp - 1;
end
endmodule

