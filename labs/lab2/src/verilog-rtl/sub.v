module sub( topinput, botinput, midoutput);
input [33,0] topinput;
input [33,0] botinput;
output reg [33,0] midoutput;
			  
always @*
begin
  if ( botinput == 0)
	midoutput = topinput;
  else
    midoutput = topinput - botinput;
end

endmodule
