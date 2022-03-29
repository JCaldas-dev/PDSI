module addsub(A, B, add_sub, Y);
input A, B, add_sub;
output reg Y;
			  
always @*
begin
  if ( add_sub )
	Y = A - B;
  else
    Y = A + B;
end

endmodule
