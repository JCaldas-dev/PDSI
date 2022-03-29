module sum( topinput, botinput, midoutput);
input [33,0] topinput;
input [33,0] botinput;
output reg [33,0] midoutput;
			  
always @*
begin
  if ( topinput == 0 )
	midoutput = botinput;
  else if ( botinput == 0)
	midoutput = topinput;
  else
    midoutput = topinput + botinput;
end

endmodule
