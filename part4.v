module part4(SW,KEY,HEX3,HEX2,HEX1,HEX0,LEDR);
	input [3:0]KEY;
	input [9:0]SW;
	output [9:0]LEDR;
	output[0:6]HEX0,HEX1,HEX2,HEX3;
	wire clock, enable, clear;
	wire [15:0]C;
	
	assign clock = KEY[0];
	assign enable = SW[1];
	assign clear = SW[0];
	shiftn S1 (clear, enable, clock, C);

	hdisp H0 (C[3:0],HEX0);
	hdisp H1 (C[7:4],HEX1);
	hdisp H2 (C[11:8],HEX2);
	hdisp H3 (C[15:12],HEX3);
endmodule
	
module hdisp(c, leds);
	input [3:0] c;
	output reg [0:6]leds;
	always@(c)
	case(c)
		0:leds = 7'b0000001;
		1:leds = 7'b1001111;
		2:leds = 7'b0010010;
		3:leds = 7'b0000110;
		4:leds = 7'b1001100;
		5:leds = 7'b0100100;
		6:leds = 7'b0100000;
		7:leds = 7'b0001111;
		8:leds = 7'b0000000;
		9:leds = 7'b0000100;
		10:leds = 7'b0001000;
		11:leds = 7'b1100000;
		12:leds = 7'b0110001;
		13:leds = 7'b1000010;
		14:leds = 7'b0110000;
		15:leds = 7'b0111000;
		default:leds = 7'bx;
	endcase
endmodule
	
module shiftn (Resetn, enable, clock, Q);
	parameter n = 16;
	//input [0:n-1]D;
	input Resetn, clock, enable;
	output reg [0:n-1]Q;
	//Q = 0;
	always @ (negedge Resetn, posedge clock)
		if (Resetn == 0)
			Q <= 0;
		else if (enable == 1)
			Q <= Q + 1;
endmodule
