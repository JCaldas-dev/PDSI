module mux(A, B, Sel, Y);
input A, B, Sel;
output reg Y;
			  
always @*
begin
  if ( Sel )
	Y = A;
  else
    Y = B;
end

endmodule
