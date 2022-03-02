`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:11 11/10/2021 
// Design Name: 
// Module Name:    baggage_drop 
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
module baggage_drop (
    output   [6 : 0]   seven_seg1, 
    output   [6 : 0]   seven_seg2,
    output   [6 : 0]   seven_seg3,
    output   [6 : 0]   seven_seg4,
    output   [0 : 0]   drop_activated,
    input    [7 : 0]   sensor1,
    input    [7 : 0]   sensor2,
    input    [7 : 0]   sensor3,
    input    [7 : 0]   sensor4,
    input    [15: 0]   t_lim,
    input              drop_en);
	 
	 wire [7:0] wire1;
	 wire [15:0] wire2;
	 wire [15:0] wire3;
	 
	sensors_input Se_In(
   .height(wire1[7:0]),
   .sensor1(sensor1),
   .sensor2(sensor2),
   .sensor3(sensor3),
   .sensor4(sensor4));
	
	square_root Sq_Ro(
    .out(wire2[15:0]),
    .in(wire1[7:0]));
	
	assign wire3 = wire2 / 2;
	
	display_and_drop Di_An_Dr(
    .seven_seg1(seven_seg1[6:0]), 
    .seven_seg2(seven_seg2[6:0]),
    .seven_seg3(seven_seg3[6:0]),
    .seven_seg4(seven_seg4[6:0]),
    .drop_activated(drop_activated),
    .t_act(wire3[15:0]),
    .t_lim(t_lim[15:0]),
    .drop_en(drop_en));
	 
endmodule
