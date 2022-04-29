module dff32( CLK, en, reset, Din, Qout);
input CLK, en, reset;
input [31:0] Din;
output reg [31:0] Qout;

always @(posedge CLK)
if(reset)
    Qout <= 32'h0;
else
begin
	if( en )
		Qout <= Din;
end

endmodule