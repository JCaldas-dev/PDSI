module dff( CLK, en, D, Q);
input CLK, D;
output reg Q;

always @(posedge CLK)
begin
	if( en )
		Q <= D;
end

endmodule