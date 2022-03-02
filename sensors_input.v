`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:28 11/10/2021 
// Design Name: 
// Module Name:    sensors_input 
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
module sensors_input (
   output reg [7 : 0]   height,
   input    [7 : 0]   sensor1,
   input    [7 : 0]   sensor2,
   input    [7 : 0]   sensor3,
   input    [7 : 0]   sensor4);
	
	reg[10:0] medie;
	reg[8:0] sensor1_shifted;
	reg[8:0] sensor2_shifted;
	reg[8:0] sensor3_shifted;
	reg[8:0] sensor4_shifted;
	
	always @(*) begin
	
		sensor1_shifted = sensor1;
		sensor2_shifted = sensor2;
		sensor3_shifted = sensor3;
		sensor4_shifted = sensor4;
		
		//shiftam valorile cu un bit la stanga pentru a face loc zecimalei
		sensor1_shifted = (sensor1_shifted << 1);
		sensor2_shifted = (sensor2_shifted << 1);
		sensor3_shifted = (sensor3_shifted << 1);
		sensor4_shifted = (sensor4_shifted << 1);
		
		//se calculeaza media cu conditia prezentata in cerinta daca un senzor este 0, anuleaza automat si celalalt senzor de aceasi paritate
		if(sensor1 == 0 || sensor3 == 0) begin
			medie = (sensor2_shifted + sensor4_shifted) / 2; 
		end else if(sensor2 == 0 || sensor4 == 0) begin 
			medie = (sensor1_shifted + sensor3_shifted) / 2;
		end else begin 
			medie = (sensor1_shifted + sensor2_shifted + sensor3_shifted + sensor4_shifted) / 4;	
		end
		
		//verificam rotunjirea daca bitul 0 este 1 inseamna ca numarul are macar .5 dupa virgula deci se incrementeaza
		if (medie[0] == 1) begin
			medie = medie + 1;
		end
		
		//se transfera in height valoarea mediei calculata mai sus
		height = medie[8:1];
	end
	
endmodule