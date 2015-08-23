`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:14:46 08/22/2015 
// Design Name: 
// Module Name:    Registro 
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
module Registro(
	 input wire Clk_R, Enable_R,
    input wire [7:0]DecoT, 
	 output reg [7:0]Reg_Temp
	 );


always@(posedge Clk_R, negedge Enable_R)
	begin 
		if(Enable_R == 1'b0)
			Reg_Temp <= 8'd0; 
		else 
			Reg_Temp <= DecoT;
	end
endmodule
