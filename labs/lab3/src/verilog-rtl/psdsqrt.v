module psdsqrt( 
                input clock,
				input reset,
				input start,
				input stop, 
				input [31:0] xin,
				output reg [15:0] sqrt,
			  );
			  
unsigned int xin, sqrtx;
sqrtx = (int) sqrt( (double) xin );

endmodule
// end of module rec2pol