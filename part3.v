module part3(KEY,SW,HEX0,HEX1);
	input[0:0]KEY;
	input[0:1]SW;
	output[0:6]HEX0,HEX1;
	wire [0:7]Q;
	
	t_ff(SW[1],KEY[0],Q[0],SW[0]);
	t_ff((SW[1]&Q[0]),KEY[0],Q[1],SW[0]);
	t_ff((SW[1]&Q[0]&Q[1]),KEY[0],Q[2],SW[0]);
	t_ff((SW[1]&Q[0]&Q[1]&Q[2]),KEY[0],Q[3],SW[0]);
	t_ff((SW[1]&Q[0]&Q[1]&Q[2]&Q[3]),KEY[0],Q[4],SW[0]);
	t_ff((SW[1]&Q[0]&Q[1]&Q[2]&Q[3]&Q[4]),KEY[0],Q[5],SW[0]);
	t_ff((SW[1]&Q[0]&Q[1]&Q[2]&Q[3]&Q[4]&Q[5]),KEY[0],Q[6],SW[0]);
	t_ff((SW[1]&Q[0]&Q[1]&Q[2]&Q[3]&Q[4]&Q[5]&Q[6]),KEY[0],Q[7],SW[0]);
	

	hexdisp(Q[0:3],HEX0[0:6]);
	hexdisp(Q[4:7],HEX1[0:6]);		
endmodule

module t_ff(E,clk,q,R);
	input clk,E,R;
	output reg q;
	always @(posedge clk)
		if(!R)
			q<=1'b0;
		else if(E)
			q<=~q;
		
endmodule

module hexdisp(s,hex);
	input[0:3]s;
	output [0:6]hex;

	assign hex[0]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]&~s[1]&~s[0]) | ( s[3]&~s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]& s[0]);
	assign hex[1]=(~s[3]& s[2]&~s[1]& s[0]) | (~s[3]& s[2]& s[1]&~s[0]) | ( s[3]&~s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]&~s[0]) | ( s[3]& s[2]& s[1]);
	assign hex[2]=(~s[3]&~s[2]& s[1]&~s[0]) | ( s[3]& s[2]&~s[1]&~s[0]) | ( s[3]& s[2]& s[1]);
	assign hex[3]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]&~s[1]&~s[0]) | (~s[3]& s[2]& s[1]& s[0]) | ( s[3]&~s[2]& s[1]&~s[0]) | ( s[3]& s[2]& s[1]& s[0]);
	assign hex[4]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]&~s[2]& s[1]& s[0]) | (~s[3]& s[2]&~s[1]&~s[0]) | ( s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]& s[0]);
	assign hex[5]=(~s[3]&~s[2]&~s[1]& s[0]) | (~s[3]& s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]& s[0]) | (~s[3]&~s[2]& s[1]);
	assign hex[6]=(~s[3]& s[2]& s[1]& s[0]) | ( s[3]& s[2]&~s[1]&~s[0]) | (~s[3]&~s[2]&~s[1]);

endmodule 