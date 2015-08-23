`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:05:06 08/22/2015
// Design Name:   Registro
// Module Name:   C:/Users/Karina/Desktop/Miras VI/Digitales/II Proyecto/II_Proyecto/Bench_Reg.v
// Project Name:  II_Proyecto
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Registro
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Bench_Reg;

	// Inputs
	reg Clk_R;
	reg Enable_R;
	reg [7:0] DecoT;

	// Outputs
	wire [7:0] Reg_Temp;

	// Instantiate the Unit Under Test (UUT)
	Registro uut (
		.Clk_R(Clk_R), 
		.Enable_R(Enable_R), 
		.DecoT(DecoT), 
		.Reg_Temp(Reg_Temp)
	); 

	initial begin
		// Initialize Inputs
		Clk_R = 0;
		Enable_R = 0;
		DecoT = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		Enable_R = 1 ; 
		DecoT = 32 ; 
		
		#100; 
		Enable_R = 1 ; 
		DecoT = 33 ; 

		#100;
		Enable_R = 1 ; 
	//	DecoT =  ; 

	end
      always begin #5 Clk_R = ~Clk_R ; end 
endmodule
 
