`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:11 02/15/2015 
// Design Name: 
// Module Name:    Universal_Shift_Register 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// Registro universal de desplazamiento cuyas funciones son: hold,shift_left,
//	shift_right y load.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Universal_Shift_Register
	#(parameter N = 8) //Definición de los parámetros, N = # de bits
	(
		input wire clk, //system clock
		input wire reset, //system reset
		input wire [N-1:0] d, //Load data
		input wire [1:0] ctrl, //Control data
		output wire [N-1:0] q //Output data
    );
//Signal Declaration
reg [N-1:0] current_state, next_state;
//body

//Combinacional
always@(posedge clk, posedge reset)
	if(reset)
		current_state <= 2'b00; //Valor inicial
	else
		current_state <= next_state; //asignación de la generación de los estados sig.

//Secuencial
always@*
	case(ctrl)
		2'b00: next_state = current_state; //hold
	//Mantiene el estado actual
		
		2'b01: next_state = {current_state[N-2:0],d[0]}; //shift left
	//Introduce el valor LSB de 'd' como el nuevo LSB para el estado siguiente
		
		2'b10: next_state = {d[0],current_state[N-1:1]}; //shift right
	//Introduce el valor LSB de 'd' como el nuevo MSB para el estado siguiente	
		
		default: next_state = d; //load
	//Copia el valor de 'd' como el nuevo estado siguiente
	endcase

//Asigna el valor de 'q'
assign q = current_state; 
//Se realiza por medio del assign porque se definió la variable 'q' como wire
endmodule


/*
	Operadores:
	{a1,a2,...,an} 		--> Concatenación
	{n{a}}					--> Replicación; se repite 'a', 'n' veces
	(condición)? a : b 	--> Condicional; si la condición es cierta, 
									 el resultado es a, en caso contrario b
	4'b0101 = 4'h5 = 4'd5;
	4'b1010 = 4'hc = 4'd12;
	1=32'd1; 0=32'b0
	
	Ej1:	
	wire [3:0] A;
	wire [7:0] B;
	assign B = { {4{A[3]}} ,A};
	Si A = 0101, B = 0000 0101
	Si A = 1101, B = 1111 1101
	
	Ej2: 
	reg [3:0] A,B;
	always@*
		B = (A != 4'b1111) ? A+1'b1 : 4'b0;
	Si A = 4'b1010, B = 4'b1011
	Si A = 4'b1111, B = 4'b0000 = 4'd0 = 4'h0;
*/





