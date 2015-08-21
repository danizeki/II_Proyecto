`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UTech Corp
 
// Create Date:    22:29:25 08/19/2015 
// Design Name: 
// Module Name:    Filtro ( CODIGO ORIGINAL )
//	Este modulo consiste en discriminar los datos que estan antes de un comando de ruptura,
// y copia la palabra inmediata despues de la ruptura (F0). 

//////////////////////////////////////////////////////////////////////////////////
module Filtro(
	input wire Clk_F, Reset_F,
	input wire [7:0] ps2_Rx,
	output reg [7:0] Save 
    );

reg [1:0]x, xp ; 
parameter [1:0] 
	State_Check = 2'd0, State_Durante_Palabra = 2'd1,
	State_Despues_Palabra = 2'd2, State_Incondicional = 2'd3 ; 

localparam Break = 8'hf0 ; 

always@(posedge Clk_F, posedge Reset_F)
	if(Reset_F == 1'b1)	
		x <= State_Check ; 
	else
		x <= xp ; 

always@*
	begin 
		xp = x ; 
		Save = 8'd0 ; 
		case(x) 
			State_Check: // Detecta cuando pasa F0
					if(ps2_Rx != Break)
						xp = State_Check ; 
					else 
						 xp = State_Durante_Palabra ; 
						
			State_Durante_Palabra:
					if(ps2_Rx == Break) 
						xp = State_Durante_Palabra ; 
					else
						xp = State_Despues_Palabra ; 
			
			State_Despues_Palabra:
					if(ps2_Rx != Break)
						Save = ps2_Rx ;
					else 
						xp = State_Incondicional ;
	
			State_Incondicional:
					begin xp = State_Check ; end 
						
		endcase
	end				
 
endmodule	
