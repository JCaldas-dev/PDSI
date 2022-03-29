module multiplexer( topinput, botinput, choose, midoutput);
input topinput;
input botinput;
input choose;
output reg midoutput;
			  
always @*
begin
  if ( choose == 1 )
	midoutput = topinput;
  else
    midoutput = botinput;
end

endmodule
