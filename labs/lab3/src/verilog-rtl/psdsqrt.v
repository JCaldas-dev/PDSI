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

wire [31:0] Q;
wire [31:0] sqtestsqrt;
wire [15:0] testsqrt;
wire [15:0] leftD;
wire [15:0] rightD;
wire [15:0] rightQ;

dff init(
			 .addr( clock ),
			 .data( start ),
			 .data( reset ),
			 .data( xin ),
			 .data( Q )
			);

sqtestsqrt = testsqrt * testsqrt;


if (start) 
    D = 16'd0
else 
begin
    if (Q >= ( sqtestsqrt ))
        leftD = testsqrt
    else
        leftD = tempsqrt
end

dff leftreg(
			 .addr( clock ),
			 .data( 1 ),
			 .data( reset ),
			 .data( leftD ),
			 .data( tempsqrt )
			);

dff rightreg(
			 .addr( clock ),
			 .data( 1 ),
			 .data( reset ),
			 .data(  ),
			 .data( rightQ )
			);

testsqrt = tempsqrt || rightQ;

dff out(
			 .addr( clock ),
			 .data( stop ),
			 .data( reset ),
			 .data( tempsqrt ),
			 .data( sqrt )
			);
			
endmodule