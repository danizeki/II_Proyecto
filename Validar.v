`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UTech Corp
// Engineer: 
// 
// Create Date:    01:05:31 08/23/2015 
// Design Name: 
// Module Name:    Validar 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 	(Codigo Original)
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Validar(
	input wire Clk_V, Reset_V,
	input wire [7:0] Save_KeyCode,
	output reg [7:0] Valid_KeyCode,
	output reg Led_Invalid
	);

localparam [7:0]	// Parametro Rx
A = 8'h1c, E = 8'h24,
Uno = 8'h16, Dos = 8'h1e, Tres = 8'h26, Cuatro = 8'h25, Cinco = 8'h2e, Seis = 8'h36;

localparam [7:0]	// Parametro Ascii
A_A = 8'h41, E_A = 8'h45,
Cero_A = 8'h30, Uno_A = 8'h31, Dos_A = 8'h32, Tres_A = 8'h33, Cuatro_A = 8'h34, Cinco_A = 8'h35, Seis_A = 8'h36;

reg Enable_V;
wire Enable_Next; 
reg [7:0]Y;
reg [2:0]Select; 	  	 
 
// Secuencial
always@(posedge Clk_V, posedge Reset_V)
	if(Reset_V == 1'b1)
		Enable_V <= 1'b0 ; 
	else 
		Enable_V <= Enable_Next ;	

assign Enable_Next = (Select) ? 1'b1 : 1'b0 ;

// Deco
always@* 
	begin
		Y = 8'h30 ;
		Select = 3'd0 ;
	case(Save_KeyCode)		
		8'h45: Y = 8'h30; //0
		8'h16: 
				begin Y = 8'h31; //1
						Select = 3'd1 ;
				end
		8'h1e: 
				begin Y = 8'h32; //2
						Select = 3'd2 ;
				end 
		8'h26: begin Y = 8'h33; //3
						Select = 3'd3 ;
				end 
		8'h25: begin Y = 8'h34; //4
						Select = 3'd4 ;
				end 
		8'h2e: begin Y = 8'h35; //5
						Select = 3'd5 ;
				end 
		8'h36: begin Y = 8'h36; //6
						Select = 3'd6 ;
				end 
		8'h3d: Y = 8'h37; //7
		8'h3e: Y = 8'h38; //8
		8'h46: Y = 8'h39; //9

		8'h1c: 
				 begin Y = 8'h41; //A
						Select = 3'd7 ;
				end 
		8'h24: 
				begin Y = 8'h45; //E
						Select = 3'd0 ;			/// 8 Es cero, Cambiar a 8 subiendo a 4 bits 
				end 
		8'h32: Y = 8'h42; //B
		8'h21: Y = 8'h43; //C
		8'h23: Y = 8'h44; //D
		8'h2b: Y = 8'h46; //F
		8'h34: Y = 8'h47; //G
		8'h33: Y = 8'h48; //H
		8'h43: Y = 8'h49; //I
		8'h3b: Y = 8'h4a; //J
		8'h42: Y = 8'h4b; //K
		8'h4b: Y = 8'h4c; //L
		8'h3a: Y = 8'h4d; //M
		8'h31: Y = 8'h4e; //N
		8'h44: Y = 8'h4f; //O
		8'h4d: Y = 8'h50; //P
		8'h15: Y = 8'h51; //Q
		8'h2d: Y = 8'h52; //R
		8'h1b: Y = 8'h53; //S
		8'h2c: Y = 8'h54; //T
		8'h3c: Y = 8'h55; //U
		8'h2a: Y = 8'h56; //V
		8'h1d: Y = 8'h57; //W
		8'h22: Y = 8'h58; //X
		8'h35: Y = 8'h59; //Y
		8'h1a: Y = 8'h5a; //Z
		
		8'h0e: Y = 8'h60; //' '
		8'h4e: Y = 8'h2d; //-
		8'h55: Y = 8'h3d; //=
		8'h54: Y = 8'h5b; //[
		8'h5b: Y = 8'h5d; //]
		8'h5d: Y = 8'h5c; //\
		8'h4c: Y = 8'h3b; //; 
		8'h52: Y = 8'h27; //''
		8'h41: Y = 8'h2c; //,
		8'h49: Y = 8'h2e; //.
		8'h4a: Y = 8'h2f; //  /
		
		8'h29: Y = 8'h20; //(space)
		8'h5a: Y = 8'h0d; //(enter, cr)
		8'h66: Y = 8'h08; //(backspace)

		default: Y = 8'd0 ; //*
	endcase
	end 

// Combinacional 
always@*	
	begin
		Valid_KeyCode = 8'd0 ;
		Led_Invalid = 1'b0 ; 
		if(Enable_V == 1'b1)
			begin
			case(Select)		
				0 : Valid_KeyCode = Y ; //  E
				1 : Valid_KeyCode = Y ; 
				2 : Valid_KeyCode = Y ;  
				3 : Valid_KeyCode = Y ;
				4 : Valid_KeyCode = Y ; 
				5 : Valid_KeyCode = Y ;
				6 : Valid_KeyCode = Y ;
			//	7 : Valid_KeyCode = Y ;
				default : Valid_KeyCode = Y ;  
			endcase
			end
		else
			Led_Invalid = 1'b1;
	end 	
		
endmodule
