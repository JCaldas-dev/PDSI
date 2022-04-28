module dff( CLK, en, reset, D, Q);
input CLK, en, reset, D;
output reg Q;

always @(posedge CLK)
if(reset)
    Q <= 0;
else
begin
	if( en )
		Q <= D;
end

endmodule