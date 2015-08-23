`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:10:42 08/17/2015 
// Design Name: 
// Module Name:    Tx_Box 
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
module Tx_Box(
	input wire clk_TxB, reset_TxB,
	input wire wr_uart_TxB,
	input wire [7:0]w_data_TxB, 
	output wire tx_TxB, 
	output wire tx_full_TxB, 
	
	input wire tick_TxB // Se convierte en wire para instancia sig
    );

wire tx_empty_TxB, tx_fifo_not_empty_TxB ; 
wire tx_done_tick_TxB ; 
wire [7:0] tx_fifo_out_TxB ;

Fifo_Tx Fifo_TX1 (
    .clk_fftx(clk_TxB), 
    .reset_fftx(reset_TxB), 
    .rd_fftx(tx_done_tick_TxB), 
    .wr_fftx(wr_uart_TxB), 
    .w_data_fftx(w_data_TxB), 
    .empty_fftx(tx_empty_TxB), 
    .full_fftx(tx_full_TxB), 
    .r_data_fftx(tx_fifo_out_TxB)
    );
/*#(.B(DBIT), .W(FIFO_W)) */


uart_tx Tx_Unity (
    .clk_Box_Tx(clk_TxB), 
    .reset_Box_Tx(reset_TxB), 
    .tx_star_Box_Tx(tx_fifo_not_empty_TxB), 
    .s_tick_Box_Tx(tick_TxB), 
    .din_Box_Tx(tx_fifo_out_TxB), 
    .tx_done_tick_Box_Tx(tx_done_tick_TxB), 
    .tx_Box_Tx(tx_TxB)
    );

assign tx_fifo_not_empty_TxB = ~tx_empty_TxB; 

endmodule
