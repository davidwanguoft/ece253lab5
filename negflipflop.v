module negflipflop(D, Clock, Q);
	input D, Clock; 
	output reg Q;
	
	always@(negedge Clock)
		Q = D;
		
endmodule

