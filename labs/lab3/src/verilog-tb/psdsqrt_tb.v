`timescale 1ns / 1ps

module psdsqrt_tb;

  // Inputs
  reg clock;
  reg reset;
  reg start;
  reg stop;
  reg [31:0] x0;

  // Outputs
  reg [15:0] y0;

  psdsqrt uut (
    .clock(clock),
    .reset(reset),
    .start(start),
    .stop(stop),
    .xin(x0)
    .sqrt(y0)
  )

  initial begin
		clock = 0;
		reset = 0;
		start = 0;
    stop = 0;
		x0 = 0;
	end

  initial
	begin
	  #11
	  forever #5 clock = ~clock;
	end

  initial
  begin
    #101
    reset = 1;
    #20
    reset = 0;
  end

  integer printresults = 1;


  initial
	begin
	  #10
	  @(negedge reset);

	  repeat (10)
	  	@(negedge clock);

	  // Call the task to start a conversion:
	  execcordic( 123, 456 );

	  $stop;

	end
