`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:53 11/10/2021  
// Design Name: 
// Module Name:    square_root 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module square_root (
    output reg [15:0] out,
    input  [7:0] in );

	reg [15:0] base;
	reg [15:0] y;
	reg [31:0] x;

	always@(*) begin
		out = 16'b00000000_00000000;;
		base = 16'b10000000_00000000; //baza incepe cu cel mai semnificativ (mare) bit (cel din stanga)
		y = 16'b00000000_00000000;
		x = 32'd0;
		x[31:24] = in;
		  
		repeat(16) begin //se repeta urmatoarele operatii pentru fiecare bit din base
			y = y + base; //se adauga baza la y care v-a reprezenta valoarea radicalului
			if ((y * y) > in) begin
				 y = y - base; //se scade baza daca valoarea radicalului la patrat este mai mare ca intrarea
			end 
			base = base / 2; // se shifteaza la dreapta (mutam bitul unu pe o pozitie precedenta)
		end
		out[11:0] = y[15:4]; // se transfera valoarea obtinuta a radicalului in Y in out
	end



endmodule