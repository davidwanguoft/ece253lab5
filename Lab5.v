module d_latch (D, clk, Q);
	input D, clk;
	output reg Q;
	
	always@(D, clk)
		if(clk)
			Q = D;
			
endmodule

module posflipflop(D, Clock, Q);
	input D, Clock;
	output reg Q;
	
	always @(posedge Clock)
		Q = D;
		
endmodule

module negflipflop(D, Clock, Q);
	input D, Clock; 
	output reg Q;
	
	always@(negedge Clock)
		Q = D;
		
endmodule

