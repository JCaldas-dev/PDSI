module mdl (CLK, en, muxSel, inputValue, A, B, Y);
input CLK, en, muxSel;
input [31:0] inputValue;
input signed [33:0] A;
input [5:0] B;
output reg [33:0] Y;

assign [33:0] shift = A >>> B;
assign [33:0] sum = Y + shift;
assign [33:0] dif = Y - shift;

wire [33:0] muxout;

mux mux1(
		 .A(sum),
		 .B(dif),
		 .Sel(),
		 .Y(muxout)
);

wire [33:0] D;

mux mux2(
		 .A(inputValue),
		 .B(muxout),
		 .Sel(muxSel),
		 .Y(D)
);

dff dff1(
		 .CLK(CLK),
		 .en(en),
		 .D(D),
		 .Q(Y)
);
endmodule
