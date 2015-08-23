`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:24:14 08/23/2015
// Design Name:   Validar
// Module Name:   C:/Users/Karina/Desktop/Miras VI/Digitales/II Proyecto/II_Proyecto/Bench_Validar.v
// Project Name:  II_Proyecto
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Validar
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Bench_Validar;

	// Inputs
	reg Clk_V;
	reg Reset_V;
	reg [7:0] Save_KeyCode;

	// Outputs
	wire [7:0] Valid_KeyCode;
	wire Led_Invalid;

	// Instantiate the Unit Under Test (UUT)
	Validar uut (
		.Clk_V(Clk_V), 
		.Reset_V(Reset_V), 
		.Save_KeyCode(Save_KeyCode), 
		.Valid_KeyCode(Valid_KeyCode), 
		.Led_Invalid(Led_Invalid)
	);
 
	initial begin
		// Initialize Inputs
		Clk_V = 0;
		Reset_V = 1;
		Save_KeyCode = 0; 
		#100; 
		
		Reset_V = 0;
		Save_KeyCode = 8'h32; // Envia una B
		#100;
		
		Reset_V = 0;
		Save_KeyCode = 8'h25; // Envia una E

	
	end
			always begin #5 Clk_V = ~Clk_V ; end 
endmodule

