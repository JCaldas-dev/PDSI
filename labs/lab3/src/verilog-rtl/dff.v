module dff( CLK, en, reset, Din, Qout);
input CLK, en, reset, Din;
output reg Qout;

always @(posedge CLK)
if(reset)
    Qout <= 0;
else
begin
	if( en )
		Qout <= Din;
end

endmodule