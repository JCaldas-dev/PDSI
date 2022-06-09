module reg_bank(
	input clock, 			// Master clock, active in the posedge
	input reset, 			// Master reset, synchronous and active high
	//--- Data input port ----------------------------------------------------
	input regwen, 			// Register write enable: set to 1 to write the register
							// selected by selwreg with the data at port inA
	input [63:0] inA, 		// Data input
	input [3:0] selwreg, 	// Select register index [0 to 15] to write data from port inA
	input [1:0] endreg, 	// Data enable: 00-write both data fields
							// 				10/01-write only data field selected by 1’b0
							// 				11: swap high word and low word
	//--- Data output ports --------------------------------------------------
	output reg [63:0] outA, // Data output A, registered
	output reg [63:0] outB, // Data output B, registered
	input [3:0] seloutA, 	// Select register index [0 to 15] to output port outA
	input [3:0] seloutB, 	// Select register index [0 to 15] to output port outB
	input cnstA, 			// Define whether the output ports A and B are loaded with
	input cnstB, 			// the contents of the register bank or a fixed constant
	input enrregA, 			// Read enable to output register outA (loads output register)
	input enrregB 			// Read enable to output register outB (loads output register)
);

reg [0:63] bank [16];

always @(posedge clock)
if(reset)
	begin
		outA <= 32'h0;
		outB <= 32'h0;
	end
else
begin
	if(regwen == 1)
		begin
			case(endreg)
				2'b00: bank[selwreg] <= inA;
				2'b01: bank[selwreg] <= ((bank[selwreg] & 64'h00000000_FFFFFFFF) | (inA & 64'hFFFFFFFF_00000000));
				2'b10: bank[selwreg] <= ((bank[selwreg] & 64'hFFFFFFFF_00000000) | (inA & 64'h00000000_FFFFFFFF));
				default: bank[selwreg] <= ((inA & 64'h00000000_FFFFFFFF) << 32) | ((inA & 64'hFFFFFFFF_00000000) >> 32);
			endcase
		end

	if(enrregA)
		if(cnstA)
			begin
				case(seloutA)
					4'h1: outA <= 64'h00000000_00000001;
					4'h3: outA <= 64'h00000000_FFFFFFFF;
					4'h4: outA <= 64'h00000001_00000000;
					4'h5: outA <= 64'h00000001_00000001;
					4'h7: outA <= 64'h00000001_FFFFFFFF;
					4'hC: outA <= 64'hFFFFFFFF_00000000;
					4'hD: outA <= 64'hFFFFFFFF_00000001;
					4'hF: outA <= 64'hFFFFFFFF_FFFFFFFF;
					default: outA <= 64'h00000000_00000000;
				endcase
			end
		else
			outA <= bank[seloutA];

	if(enrregB)
		if(cnstB)
			begin
				case(seloutB)
					4'h1: outB <= 64'h00000000_00000001;
					4'h3: outB <= 64'h00000000_FFFFFFFF;
					4'h4: outB <= 64'h00000001_00000000;
					4'h5: outB <= 64'h00000001_00000001;
					4'h7: outB <= 64'h00000001_FFFFFFFF;
					4'hC: outB <= 64'hFFFFFFFF_00000000;
					4'hD: outB <= 64'hFFFFFFFF_00000001;
					4'hF: outB <= 64'hFFFFFFFF_FFFFFFFF;
					default: outB <= 64'h00000000_00000000;
				endcase
			end
		else
			outB <= bank[seloutB];
end

endmodule
