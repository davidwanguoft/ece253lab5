module part5 (CLOCK_50, HEX0);
	input CLOCK_50;
	output[0:6] HEX0;
	
	//4bit output
	wire [25:0]count;
	reg D,resetn,counter_reset;
	wire [3:0]A;
	//D is timer, changes to 1 for one clock cycle every second
	nbit_counter U1(count, CLOCK_50, resetn);
	always @ (posedge CLOCK_50)
	begin
			if (count == 26'd50000000)
			begin
				resetn <= 0;
				D <= 1;
			end
			else
			begin
				resetn <= 1;
				D <= 0;
			end
			if (A[3] & ~A[2] & A[1] & ~A[0]) //reaches 10
				counter_reset = 0;
			else
				counter_reset = 1;
	end
	
	T_FF T1 (D, CLOCK_50, counter_reset, A[0]);
	T_FF T2 (D & A[0], CLOCK_50, counter_reset, A[1]);
	T_FF T3 (D & A[0] & A[1], CLOCK_50, counter_reset, A[2]);
	T_FF T4 (D & A[0] & A[1] & A[2], CLOCK_50, counter_reset, A[3]);
	
	hdisp H1 (A,HEX0);
	
endmodule
	

module nbit_counter (count, clock, Resetn); //fast counter
	input clock, Resetn;
	parameter n = 26;
	output reg [n-1:0] count;
	initial
		count = 0;
	always @ (posedge clock)
			if (Resetn == 0)
				count <= 0;
			else
				count <= count + 1'b1;
endmodule

module T_FF (T, clock, Resetn, q);
	input clock, T, Resetn;
	output reg q;
	always @ (posedge clock)
		if (Resetn == 0)
			q = 1'b0;
		else if (T==1)
			q <= ~q;
endmodule


 