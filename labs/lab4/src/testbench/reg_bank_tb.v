`timescale 1ns / 1ns

module reg_bank_tb;

// general parameters
parameter CLOCK_PERIOD = 10;              // Clock period in ns
parameter MAX_SIM_TIME = 100_000_000;     // Set the maximum simulation time (time units=ns)


// Registers for driving the inputs:
reg clock, reset;
reg regwen;
reg [63:0] inA;
reg [3:0] selwreg;
reg [1:0] endreg;
reg [3:0] seloutA;
reg [3:0] seloutB;
reg cnstA;
reg cnstB;
reg enrregA;
reg enrregB;
// Wires to connect to the outputs:
wire [63:0] outA;
wire [63:0] outB;


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

`define NULL 0

initial
begin

	clock = 1'b0;
	reset = 1'b0;
  regwen = 1'b0;
  inA = 64'b1;
  selwreg = 4'b0;
  endreg = 2'b0;
  seloutA = 4'b0;
  seloutB = 4'b0;
  cnstA = 1'b0;
  cnstB = 1'b0;
  enrregA = 1'b0;
  enrregB = 1'b0;

end

initial
begin
  forever
    # (CLOCK_PERIOD / 2 ) clock = ~clock;
end

initial
begin
  # (CLOCK_PERIOD/3) // wait a fraction of the clock period to
                     // misalign the reset pulse with the clock edges:
  reset = 1;
  # (2 * CLOCK_PERIOD ) // apply the reset for 2 clock periods
  reset = 0;
  regwen = 1;
  selwreg = 4'b0011;
  endreg = 2'b00;

  # (2 * CLOCK_PERIOD)
  seloutA = 4'b0011;
  seloutB = 4'b0001;
  enrregA = 1;
  enrregB = 1;
  cnstA = 0;
  cnstB = 1;

end

initial
begin
  # ( MAX_SIM_TIME )
  $stop;
end

initial
begin
	$dumpfile("mysimdata.vcd");// The filename with the waveform data
	$dumpvars(0, reg_bank_tb);
// The root node to dump
end


initial
begin

  // Wait 10 clock periods
  #( 10*CLOCK_PERIOD );

  $display("A = %d, B = %d", outA, outB );

  #( 10*CLOCK_PERIOD );
  $stop;
end







endmodule
