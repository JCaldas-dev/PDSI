`timescale 1ns / 1ns

module reg_bank_tb;

// general parameters
parameter CLOCK_PERIOD = 10;              // Clock period in ns
parameter MAX_SIM_TIME = 100_000_000;     // Set the maximum simulation time (time units=ns)


// Registers for driving the inputs:
reg clock, reset;
reg regwen,
reg [63:0] inA,
reg [3:0] selwreg,
reg [1:0] endreg,
reg [3:0] seloutA,
reg [3:0] seloutB,
reg cnstA,
reg cnstB,
reg enrregA,
reg enrregB 
// Wires to connect to the outputs:
wire [63:0] outA,
wire [63:0] outB,


// Instantiate the module under verification:
reg_bank reg_bank_1
      (
	    .clock(clock), // master clock, active in the positive edge
        .reset(reset), // master reset, synchronous and active high
		.regwen(regwen),
		.inA(inA),
		.selwreg(selwreg),
		.endreg(endreg),
		.seloutA(seloutA),
		.seloutB(seloutB),
		.cnstA(cnstA),
		.cnstB(cnstB),
		.enrregA(enrregA),
		.enrregB(enrregB),
		.outA(outA),
		.outB(outB)
        );


endmodule