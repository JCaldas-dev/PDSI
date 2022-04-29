module dff64( CLK, en, reset, Din, Qout);
input CLK, en, reset;
input [63:0] Din;
output reg [63:0] Qout;

always @(posedge CLK)
if(reset)
    Qout <= 64'h0;
else
begin
	if( en )
		Qout <= Din;
end

endmodule
