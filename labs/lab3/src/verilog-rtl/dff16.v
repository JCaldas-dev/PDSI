module dff16( CLK, en, reset, Din, Qout);
input CLK, en, reset;
input [15:0] Din;
output reg [15:0] Qout;

always @(posedge CLK)
if(reset)
    Qout <= 16'h0;
else
begin
	if( en )
		Qout <= Din;
end

endmodule