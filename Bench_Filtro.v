`timescale 1ns / 1ps
 

module Bench_Filtro;

	// Inputs
	reg Clk_F;
	reg Reset_F;
	reg [7:0] ps2_Rx;

	// Outputs
	wire [7:0] Save;

	// Instantiate the Unit Under Test (UUT)
	Filtro uut (
		.Clk_F(Clk_F), 
		.Reset_F(Reset_F), 
		.ps2_Rx(ps2_Rx), 
		.Save(Save)
	);

	initial begin
		// Initialize Inputs
		 
		Clk_F = 0;
		Reset_F = 1;
		ps2_Rx = 0; 
		#100 ; 
		
		Reset_F = 0;
		ps2_Rx = 8'hc4; 
       #100 ;
		 		
		//
		Reset_F = 0;
		ps2_Rx = 8'hc1;  
		#100 ;
		
		 //
		
		Reset_F = 0; 
		ps2_Rx = 8'hf0;  
		#100 ;
		
 		Reset_F = 0;
		ps2_Rx = 8'hc2;  
		#100 ;
	 
	end
			always begin #5 Clk_F = ~Clk_F ; end 
endmodule

