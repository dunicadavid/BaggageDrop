`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:09 11/10/2021 
// Design Name: 
// Module Name:    display_and_drop 
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
module display_and_drop (
    output reg  [6 : 0]   seven_seg1, 
    output reg  [6 : 0]   seven_seg2,
    output reg  [6 : 0]   seven_seg3,
    output reg  [6 : 0]   seven_seg4,
    output reg [0 : 0]   drop_activated,
    input    [15: 0]   t_act,
    input    [15: 0]   t_lim,
    input              drop_en);
	 
	 always @ (*) begin
		if (drop_en == 0) begin
			//cold
			seven_seg1 = 7'b011_1001;
			seven_seg2 = 7'b101_1100;
			seven_seg3 = 7'b011_1000;
			seven_seg4 = 7'b101_1110;
			drop_activated = 0;
		end else if (t_lim >= t_act && drop_en == 1) begin
			//drop
			seven_seg1 = 7'b101_1110;
			seven_seg2 = 7'b101_0000;
			seven_seg3 = 7'b101_1100;
			seven_seg4 = 7'b111_0011;
			drop_activated = 1;
		end else if (t_lim < t_act && drop_en == 1) begin
			//hot
			seven_seg1 = 7'b000_0000;
			seven_seg2 = 7'b111_0110;
			seven_seg3 = 7'b101_1100;
			seven_seg4 = 7'b111_1000;
			drop_activated = 0;
		end
	 end
endmodule
