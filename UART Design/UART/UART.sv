`timescale 1ns / 1ps

module UART #( 
               
			parameter Data_bits=9,
		        parameter Sp_ticks=16, 
		        parameter St_ticks=8,  
		        parameter Dt_ticks=16,
			parameter addr_width=5,
			parameter divsr_width=10,
	                parameter Read=2'b01,
	                parameter Write=2'b10,
	                parameter Read_and_Write=2'b11
				  
             )
				 
				 (
				 
				 input clk,Reset,
				 input rd_uart,wr_uart,
				 input rx,
				 input[Data_bits-2:0] w_data,
				 input[divsr_width-1:0] divsr,
				 output rx_empty,tx_full,
				 output tx,
				 output[Data_bits-2:0] r_data,
				 output incorrect_send,
				 output tx_done,
				 output rx_done
				 //output parity_bit
);



//intermediate signals declaration

logic s_ticks;
logic rx_done_tick,full;
logic[Data_bits-2:0] rx_data_out,fifo_tx_data_out;
logic tx_done_tick,tx_start;
logic full_fifo_out;
logic empty_tx_fifo;
logic parity_check;




assign tx_start= ~empty_tx_fifo;

assign tx_done = tx_done_tick;
assign rx_done = rx_done_tick;


//Transmitter

UART_TX #( .Data_bits(Data_bits), .Sp_ticks(Sp_ticks), .St_ticks(St_ticks), .Dt_ticks(Dt_ticks) ) 

           TX
               ( .clk(clk),
					.Reset(Reset),
					.s_ticks(s_ticks),
					.tx_start(tx_start),
					.tx(tx),
					.tx_done_tick(tx_done_tick),
					.parity_check(parity_check),
               .data_in(fifo_tx_data_out) );

 
 
 
 
 //Receiver
 
UART_RX #( .Data_bits(Data_bits), .Sp_ticks(Sp_ticks), .St_ticks(St_ticks), .Dt_ticks(Dt_ticks))

            RX
               ( .clk(clk),
					.Reset(Reset),
					.rx(rx),
					.s_ticks(s_ticks),
					.data_out(rx_data_out),
					.rx_done_tick(rx_done_tick), 
					.incorrect_send(incorrect_send)
					//.parity_bit(parity_bit) 
					);
 
 
 
 
 
 //Receiver fifo

FIFO #( .addr_width(addr_width), .Data_bits(Data_bits), .Read(Read), .Write(Write),
 .Read_and_Write(Read_and_Write))
 
           FIFO_RX 
              ( .clk(clk),
				  .Reset(Reset),
				  .wr(rx_done_tick),
				  .rd(rd_uart),
				  .w_data(rx_data_out),
				  .r_data(r_data),
				  .full(full_fifo_out),
				  .empty(rx_empty) );
 
 
 
 //Transmitter fifo
 
FIFO #( .addr_width(addr_width), .Data_bits(Data_bits), .Read(Read), .Write(Write),
 .Read_and_Write(Read_and_Write)) 
 
          FIFO_TX 
            ( .clk(clk),
				.Reset(Reset), 
				.wr(wr_uart), 
				.rd(tx_done_tick), 
				.w_data(w_data), 
				.r_data(fifo_tx_data_out),
            .full(tx_full),
            .empty(empty_tx_fifo) );
 
 
 
 //Baud rate generator
 
 Buad_rate_gen #( .divsr_width(divsr_width))
             
				 Buad_Gen
				   ( .clk(clk),
					  .Reset(Reset), 
					  .divsr(divsr), 
					  .tick(s_ticks) );
 
 
 
 
 
 
 endmodule 
 
