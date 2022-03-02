`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:38:59 11/11/2021
// Design Name:   square_root
// Module Name:   C:/Users/dgdun/OneDrive/Desktop/AC/tema1/test1.v
// Project Name:  tema1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: square_root
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test1;

	// Inputs
	reg [7:0] in;

	// Outputs
	wire [15:0] out;

	// Instantiate the Unit Under Test (UUT)
	square_root uut (
		.out(out), 
		.in(in)
	);

	initial begin
		// Initialize Inputs
		in = 0;
		

		// Wait 100 ns for global reset to finish
		#100;
		in = 169;
		

		// Wait 100 ns for global reset to finish
		#100;
		in = 64;
		

		// Wait 100 ns for global reset to finish
		#100;
		in = 25;
		

		// Wait 100 ns for global reset to finish
		#100;
        
		  in = 82;
		

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here

	end
      
endmodule

