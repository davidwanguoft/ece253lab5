module part6 (SW, KEY0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
	input [9:0]SW;
	output [0:6]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	wire [3:0] Q;
	wire D;
	input KEY0;
	
	reset(Q,KEY0,R);
	delay_1s(D,KEY0);
	counter_4bit(D, KEY0, R, Q);
	
	
	wire [1:0] blank;
	assign blank[1] = 1;
	assign blank[0] = 1;
	wire [11:0] M;
	
	mux_2bit_6to1(Q[2:0], SW[1:0], blank[1:0], blank[1:0], blank[1:0], SW[5:4], SW[3:2], M[1:0]);  
	char_7_seg_display(M[1:0], HEX0);
	
	mux_2bit_6to1(Q[2:0], SW[3:2],SW[1:0] , blank[1:0], blank[1:0], blank[1:0], SW[5:4],  M[3:2]);  
	char_7_seg_display(M[3:2], HEX1);
	
	mux_2bit_6to1(Q[2:0], SW[5:4], SW[3:2], SW[1:0], blank[1:0], blank[1:0], blank[1:0], M[5:4]);  
	char_7_seg_display(M[5:4], HEX2);
	
	mux_2bit_6to1(Q[2:0], blank[1:0], SW[5:4], SW[3:2],SW[1:0] , blank[1:0], blank[1:0], M[7:6]);  
	char_7_seg_display(M[7:6], HEX3);                                                                                                                                                  
	
	mux_2bit_6to1(Q[2:0], blank[1:0], blank[1:0], SW[5:4], SW[3:2], SW[1:0], blank[1:0], M[9:8]); 
	char_7_seg_display(M[9:8], HEX4);
	
	mux_2bit_6to1(Q[2:0], blank[1:0], blank[1:0], blank[1:0], SW[5:4], SW[3:2], SW[1:0], M[11:10]); 
	char_7_seg_display(M[11:10], HEX5);
	assign LEDR = SW;
	
endmodule

module reset(input [3:0]Q, input clock, output reg R);
	always@(posedge clock)
		if (Q == 4'b0110)
			R = 0;
		else 
			R = 1;
endmodule

module mux_2bit_6to1 (S, R, X, T, U, V, W, M);
	input [2:0] S;
	input [1:0] R, T, U, V, W, X; 
	output [1:0] M;
	
	assign M[1] = (~S[2]&~S[1]&~S[0]&R[1])|(~S[2]&~S[1]&S[0]&X[1])|(~S[2]&S[1]&~S[0]&T[1])|(~S[2]&S[1]&S[0]&U[1])|(S[2]&~S[1]&~S[0]&V[1])|(S[2]&~S[1]&S[0]&W[1]);
	assign M[0] = (~S[2]&~S[1]&~S[0]&R[0])|(~S[2]&~S[1]&S[0]&X[0])|(~S[2]&S[1]&~S[0]&T[0])|(~S[2]&S[1]&S[0]&U[0])|(S[2]&~S[1]&~S[0]&V[0])|(S[2]&~S[1]&S[0]&W[0]);
	
endmodule

module char_7_seg_display (M, DISPLAY);
	input [1:0] M;
	output[0:6] DISPLAY;
	
	assign DISPLAY[0] = ~(M[0]&~M[1]);
	assign DISPLAY[1] = M[0];
	assign DISPLAY[2] = M[0];
	assign DISPLAY[3] = M[1];
	assign DISPLAY[4] = M[1];
	assign DISPLAY[5] = ~(M[0]&~M[1]);
	assign DISPLAY[6] = M[1];
endmodule

module delay_1s(delay,CLOCK_50);

	output reg delay;
	input CLOCK_50;
	reg [25:0] count;

	always @(posedge CLOCK_50)
	begin

	if(count==26'd49999999)
		begin
		count<=26'd0;
		delay<=1;
		end
	else
		begin
		count<=count+1;
		delay<=0;
		end
 end

endmodule

module counter_4bit(input enable, clock, clear, output [3:0]Q);
	wire [2:0]r; 
	
	// insantiate all 8 counters
	toggle u0(enable, clock, clear, Q[0]);
	assign r[0] = enable & Q[0];
	toggle u1(r[0], clock, clear, Q[1]);
	assign r[1] =  r[0] & Q[1];
	toggle u2(r[1], clock, clear, Q[2]);
	assign r[2] =  r[1] & Q[2];
	toggle u3(r[2], clock, clear, Q[3]);
endmodule

module toggle (T, C, Clear, Q);
	input C, Clear;
	input [0:0]T; 
	output reg [0:0]Q; 
	
   always @(posedge C, negedge Clear) 
    begin 
      if (!Clear) 
        Q = 1'b0; 
      else 
        if (T) 
				Q = ~Q; 
    end 
 
endmodule 