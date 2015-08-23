`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:36:36 08/20/2015
// Design Name:   Ps2_Rx
// Module Name:   C:/Users/Karina/Desktop/Miras VI/Digitales/II Proyecto/II_Proyecto/Bench_Ps2_Rx.v
// Project Name:  II_Proyecto
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Ps2_Rx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Bench_Ps2_Rx;

	// Inputs
	reg clk_ps2_rx;
	reg reset_ps2_rx;
	reg ps2d_ps2_rx;
	reg ps2c_ps2_rx;
	reg rx_en_ps2_rx;

	// Outputs
	wire rx_done_tick_ps2_rx;
	wire [7:0] dout_ps2_rx;

	// Instantiate the Unit Under Test (UUT)
	Ps2_Rx uut (
		.clk_ps2_rx(clk_ps2_rx), 
		.reset_ps2_rx(reset_ps2_rx), 
		.ps2d_ps2_rx(ps2d_ps2_rx), 
		.ps2c_ps2_rx(ps2c_ps2_rx), 
		.rx_en_ps2_rx(rx_en_ps2_rx), 
		.rx_done_tick_ps2_rx(rx_done_tick_ps2_rx), 
		.dout_ps2_rx(dout_ps2_rx)
	);

	initial begin
		// Initialize Inputs
		clk_ps2_rx = 0;
		reset_ps2_rx = 1;
		ps2d_ps2_rx = 0;
		ps2c_ps2_rx = 0;
		rx_en_ps2_rx = 0; 
		#100;
        
		reset_ps2_rx = 0;
		ps2d_ps2_rx = 1;
		ps2c_ps2_rx = 0;
		rx_en_ps2_rx = 1; 
		#100;
		
		
	end
      
endmodule

