import uvm_pkg::*;
`include "UART_interface.sv"
`timescale 1ns / 1ns
import UART_pkg::*;
module UART_TOP;
 parameter Data_bits=9;
 parameter Sp_ticks=16; 
 parameter St_ticks=8; 
 parameter Dt_ticks=16;
 parameter addr_width=5;
 parameter divsr_width=10;
 parameter Read=2'b01;
 parameter Write=2'b10;
 parameter Read_and_Write=2'b11;

logic CLK;

UART_interface intf(.CLK(CLK));

 UART  #( .Data_bits(Data_bits), .Sp_ticks(Sp_ticks), .St_ticks(St_ticks), .Dt_ticks(Dt_ticks), .addr_width(addr_width), .divsr_width(divsr_width), .Read(Read), .Write(Write), .Read_and_Write(Read_and_Write)) 
    
	    UART_As_Transmitter
		 
		 ( 	.clk			(CLK),
		  	.Reset			(intf.Reset),
		  	.rd_uart		(intf.rd_uart),
			.wr_uart		(intf.wr_uart),
			.rx				(intf.tx),
			.w_data			(intf.w_data),
			.divsr			(10'd54),
			.rx_empty		(intf.rx_empty),
			.tx_full		(intf.tx_full),
			.tx				(intf.tx),
			.r_data			(intf.r_data),
			.incorrect_send	(intf.incorrect_send),
      		.tx_done		(intf.tx_done),
      		.rx_done(intf.rx_done)
			//.parity_bit(intf.parity_bit)
             ); //all the commented signals are receiver signals

// UART  #( .Data_bits(Data_bits), .Sp_ticks(Sp_ticks), .St_ticks(St_ticks), .Dt_ticks(Dt_ticks), .addr_width(addr_width), .divsr_width(divsr_width), .Read(Read), .Write(Write), .Read_and_Write(Read_and_Write)) 
    
// 	    UART_As_Receiver
		 
// 		( 	.clk			(CLK),
// 			.Reset			(intf.Reset),
// 			.rd_uart		(intf.rd_uart),
// 			.wr_uart		(),
// 			.rx				(intf.tx),//connecting the tx of UART_As_Transmitter to rx of UART_As_Receiver
// 			.w_data			(),
// 			.divsr			(10'd650),
// 			.rx_empty		(intf.rx_empty),
// 			.tx_full		(),
// 			.tx				(),
// 			.r_data			(intf.r_data),
// 			.incorrect_send	(intf.incorrect_send), 
//             .tx_done		(),
//             .rx_done		(intf.rx_done)
//         );//all commented signals are transmitter signals

always #5 CLK=~CLK;

/* if the clock frequency is 100 MHz then clock period 10ns 
if we need buad rate 16 times 115200 bits per second so 
we need to process one bit at time = 16*54*10ns=8640ns */
	 


initial begin
	CLK=0;
	intf.Reset=0;
	intf.rd_uart=0;
	intf.wr_uart=0;
  uvm_config_db #(virtual UART_interface)::set(null,"*","intf",intf);
  run_test("test");
  
end
endmodule