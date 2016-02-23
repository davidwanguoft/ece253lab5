module part2(input [7:0]SW, input KEY0, KEY1, output [0:6]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, output [0:0]LEDR);
	wire [7:0]Q, S;
	
	reg_8bit A0(SW[7:0], KEY1, KEY0, Q[7:0]);
	
	//display B
	hex7seg d0(SW[3:0], HEX0);
	hex7seg d1(SW[7:4], HEX1);
	//display A
	hex7seg d2(Q[3:0], HEX2); 
	hex7seg d3(Q[7:4], HEX3); 
	
	wire c0, c1, c2, c3, c4, c5, c6; 
	
	// add up the two 8bit numbers
	full_adder x0(Q[0], SW[0], 1'b0, S[0], c0);
	full_adder x1(Q[1], SW[1], c0, S[1], c1);
	full_adder x2(Q[2], SW[2], c1, S[2], c2);
	full_adder x3(Q[3], SW[3], c2, S[3], c3);
	full_adder x4(Q[4], SW[4], c3, S[4], c4);
	full_adder x5(Q[5], SW[5], c4, S[5], c5);
	full_adder x6(Q[6], SW[6], c5, S[6], c6);
	full_adder x7(Q[7], SW[7], c6, S[7], LEDR[0]); 
	
	//display the sum
	hex7seg d4(S[3:0], HEX4);
	hex7seg d5(S[7:4], HEX5);
endmodule

module reg_8bit(input [7:0]B, input clock, reset, output reg [7:0]Q);
	always@(negedge reset, posedge clock)
		if(!reset)
			Q <= 8'b0;
		else
			Q <= B;
endmodule

module full_adder(input a, b, ci, output s, co);
	wire d;
	assign d = a^b; 
	mux2to1 U0(b, ci, d, co);
	assign s = ci^d;
endmodule 

module mux2to1(input a, b, s, output f);
	assign f = (~s&a)|(s&b);
endmodule

module hex7seg(input [3:0]s, output [0:6]hex);
	assign hex[0]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]&~s[1]&~s[0]) | ( s[3]&~s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]& s[0]);
	assign hex[1]=(~s[3]& s[2]&~s[1]& s[0]) | (~s[3]& s[2]& s[1]&~s[0]) | ( s[3]&~s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]&~s[0]) | ( s[3]& s[2]& s[1]);
	assign hex[2]=(~s[3]&~s[2]& s[1]&~s[0]) | ( s[3]& s[2]&~s[1]&~s[0]) | ( s[3]& s[2]& s[1]);
	assign hex[3]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]&~s[1]&~s[0]) | (~s[3]& s[2]& s[1]& s[0]) | ( s[3]&~s[2]& s[1]&~s[0]) | ( s[3]& s[2]& s[1]& s[0]);
	assign hex[4]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]&~s[2]& s[1]& s[0]) | (~s[3]& s[2]&~s[1]&~s[0]) | ( s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]& s[0]);
	assign hex[5]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]& s[0]) | (~s[3]&~s[2]& s[1]);
	assign hex[6]=(~s[3]& s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]&~s[0]) | (~s[3]&~s[2]&~s[1]);
endmodule