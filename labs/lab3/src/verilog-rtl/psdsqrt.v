module psdsqrt( 
                input clock,
				input reset,
				input start,
				input stop, 
				input [31:0] xin,
				output reg [15:0] sqrt
			  );

wire [31:0] Q;
wire [31:0] sqtestsqrt;
wire [15:0] testsqrt;
wire [15:0] leftD;
wire [15:0] rightD;
wire [15:0] rightQ;

always@(posedge clock)
begin
if(reset)
begin
    Q = 32'h0;
	sqrt = 16'h0;
	tempsqrt = 16'h0;
	rightQ = 16'h0;
end
end

dff init( 
		 .addr( clock ),
		 .data( start ),
		 .data( reset ),
		 .data( xin ),
		 .data( Q )
		);
			
dff leftreg(
		 .addr( clock ),
		 .data( 16'd1 ),
		 .data( reset ),
		 .data( leftD ),
		 .data( tempsqrt )
		);
		
dff rightreg(
		 .addr( clock ),
		 .data( 1 ),
		 .data( reset ),
		 .data( rightD ),
		 .data( rightQ )
		);

dff out(
		 .addr( clock ),
		 .data( stop ),
		 .data( reset ),
		 .data( tempsqrt ),
		 .data( sqrt )
		);

always @*
begin

sqtestsqrt = testsqrt * testsqrt;

if (start) 
    D = 16'd0;
else 
begin
    if (Q >= ( sqtestsqrt ))
        leftD = testsqrt;
    else
        leftD = tempsqrt;
end

if (start)
    rightD = 16'h8000;
else
    rightD = rightQ >> 1;

testsqrt = tempsqrt | rightQ;

end		
endmodule