`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:35:16 08/13/2015 
// Design Name: 
// Module Name:    Ps2_Tx 
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
module Ps2_Rx(
	input wire clk_ps2_rx, reset_ps2_rx,
	input wire ps2d_ps2_rx, ps2c_ps2_rx, rx_en_ps2_rx,
	output reg rx_done_tick_ps2_rx,
	output wire [7:0] dout_ps2_rx
	
    );  
    
// symbol state declaration 
localparam [1:0]
idle_ps2_rx = 2'd0, dps_ps2_rx = 2'd1, load_ps2_rx = 2'd2 ; 

// signal declaration 
reg [1:0] x, xp ; 
reg [7:0] filter_reg ;
wire [7:0] filter_next ;

reg f_ps2c_ps2_rx_reg ; 
wire f_ps2c_ps2_rx_next ; 

reg [3:0] n_reg, n_next;
reg [10:0] b_reg, b_next; 
wire fall_edge ; 

// Cuerpo

always@(posedge clk_ps2_rx, posedge reset_ps2_rx)
	if(reset_ps2_rx)
		begin 
			filter_reg <= 8'b0 ; 
			f_ps2c_ps2_rx_reg <= 1'b0 ;
		end 
	else 
		begin 	
			filter_reg <= filter_next ; 
			f_ps2c_ps2_rx_reg <= f_ps2c_ps2_rx_next ; 
		end 

assign filter_next = {ps2c_ps2_rx, filter_reg[7:1]} ; 
assign f_ps2c_ps2_rx_next = (filter_reg == 8'hf) ? 1'b1 :
							(filter_reg == 8'b0) ? 1'b0 : 
							f_ps2c_ps2_rx_reg ; 

assign fall_edge = f_ps2c_ps2_rx_reg & (~f_ps2c_ps2_rx_next) ; 


// FSMD, state and data registers

always@(posedge clk_ps2_rx, posedge reset_ps2_rx) 
	if(reset_ps2_rx) 
		begin 
			x <= idle_ps2_rx ; 
			n_reg <= 4'b0 ; 
			b_reg <= 11'b0 ; 
		end 
	else 
		begin 
			x <= xp ; 
			n_reg <= n_next ; 
			b_reg <= b_next ; 
		end 
		
// Logica de estado proximo

always@*
	begin 
		xp = x ;
		rx_done_tick_ps2_rx = 1'b0 ; 
		n_next = n_reg ; 
		b_next = {ps2d_ps2_rx, b_reg[10:1]} ; 
			case(x)
				idle_ps2_rx:
						if(fall_edge & rx_en_ps2_rx)
							begin 	// cambia en el start bit
								b_next = {ps2d_ps2_rx, b_reg[10:1]} ;
								n_next = 4'b1001 ; 
								xp = dps_ps2_rx ; 
							end 
				dps_ps2_rx:	// 8 data + 1 parity + 1 stop
						if(fall_edge) 
							begin 
								b_next = {ps2d_ps2_rx, b_reg[10:1]} ; 
									if(n_reg == 1'b0) 
										xp = load_ps2_rx ; 
									else 
										n_next = n_reg-1'b1 ; 
							end 
				load_ps2_rx:	// 1 reloj extra para completar el ultimo cambio 
						begin 
							xp = idle_ps2_rx ;
							rx_done_tick_ps2_rx = 1'b1 ; 
						end 
			endcase 
	end 
	
// Salida 

assign dout_ps2_rx = b_reg[8:1] ; //data bits 


endmodule

