module addsub(A, B, is_sub, Y);
input signed A, B, is_sub;
output reg Y;
			  
always @*
begin
  if ( is_sub )
	Y = A - B;
  else
    Y = A + B;
end

endmodule

//module soma(input signed [31:0] A, input [31:0] B, output [31:0] sum);
