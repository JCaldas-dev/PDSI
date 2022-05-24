module reg_bank(
	input clock, 			// Master clock, active in the posedge
	input reset, 			// Master reset, synchronous and active high
	//--- Data input port ----------------------------------------------------
	input regwe, 			// Register write enable: set to 1 to write the register
							// selected by selwreg with the data at port inA
	input [63:0] inA, 		// Data input
	input [ 3:0] selwreg, 	// Select register index [0 to 15] to write data from port inA
	input [ 1:0] endreg, 	// Data enable: 00-write both data fields
							// 10/01-write only data field selected by 1’b0
							// 11: swap high word and low word
	//--- Data output ports --------------------------------------------------
	output reg [63:0] outA, // Data output A, registered
	output reg [63:0] outB, // Data output B, registered
	input [ 3:0] seloutA, 	// Select register index [0 to 15] to output port outA
	input [ 3:0] seloutB, 	// Select register index [0 to 15] to output port outB
	input cnstA, 			// Define whether the output ports A and B are loaded with
	input cnstB, 			// the contents of the register bank or a fixed constant
	input enrregA, 			// Read enable to output register outA (loads output register)
	input enrregB 			// Read enable to output register outB (loads output register)
);