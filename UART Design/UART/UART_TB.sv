
`timescale 1ns / 1ps

module UART_TB;


 parameter Data_bits=9;
 parameter Sp_ticks=16; 
 parameter St_ticks=8;  
 parameter Dt_ticks=16;
 parameter addr_width=5;
 parameter divsr_width=10;
 parameter Read=2'b01;
 parameter Write=2'b10;
 parameter Read_and_Write=2'b11;



 logic clk,Reset;
 logic rd_uart,wr_uart;
 logic rx;
 logic[Data_bits-2:0] w_data;
 logic[divsr_width-1:0] divsr;
 logic rx_empty,tx_full;
 logic tx;
 logic[Data_bits-2:0] r_data;
 logic incorrect_send;
 //logic parity_bit;
 
 UART  #( .Data_bits(Data_bits), .Sp_ticks(Sp_ticks), .St_ticks(St_ticks), .Dt_ticks(Dt_ticks), .addr_width(addr_width), .divsr_width(divsr_width), .Read(Read), .Write(Write), .Read_and_Write(Read_and_Write)) 
    
	    UART_tb
		 
		 ( .clk(clk),
		   .Reset(Reset),
		   .rd_uart(rd_uart),
			.wr_uart(wr_uart),
			.rx(rx),
			.w_data(w_data),
			.divsr(divsr),
			.rx_empty(rx_empty),
			.tx_full(tx_full),
			.tx(tx),
			.r_data(r_data),
			.incorrect_send(incorrect_send)
			//.parity_bit(parity_bit)
			 );
 
 
 
 
 //initial values
 initial 
 
    begin
	 
	 clk=0;
	 Reset=0;
	 rd_uart=0;
	 wr_uart=0;
	 divsr=650; // the divsr = freq/buad rate at freq=100 MHz and buad rate=9600*16 the divsr=650
	 
	 /* if the clock frequency is 100 MHz then clock period 10ns if we need buad rate 16 times 9600bits per second so we need to process one bit at time = 16*650*10ns=104000ns */
	 
	 end
	 

	 
	 
//Reset
 initial 
 
    begin 
	 
	#10 Reset=1; 
	#10 Reset=0; 
	 
	 end
	 
	 
	 
	 always #5 clk=~clk;  // the system clock frequency is 100 MHz so the clock period is 10 ns
	 
	 
	 
	 
	 
	 
//transmit data

 initial 
     
	 begin
	 
	 #100
	 
	 w_data=8'b11100011;
	 
	 wr_uart=1; #10
	 wr_uart=0; 
	 
	 #1090000

	 
	 
	 
	 w_data=8'b11110000;
	 
	 wr_uart=1; #10
	 wr_uart=0; 
	 
	 #1090000
	 
	 wr_uart=0; 

	 
	 end
 
 
//receive data

 initial 
    
	 begin
	 
	 
	 #10000 //delay between receiver and transmiter
	 
 //#######################first case########################## 
	 //idle state 
	 
	 rx=1;
	 
	 #10
	 
	 
	 //start bit
	 
	 rx=0;
	 
	 #52000 //start bit duration is 8 ticks as defined in UART top module so the duration= 8*650*10 ns=52000ns
	 
	 
	 //data bits
	 
	 //firts bit
	 
	 rx=1;
	 
	 #104000

	 
	 //second bit
	 
	 rx=1;
	 
	 #104000
	 
	 
	 //third bit
	 
	 rx=0;
	 
	 #104000
	 
	 
	 //fourth bit
	 
	 rx=0;
	 
	 #104000
	 

	 //fifth bit
	 
	 rx=0;
	 
	 #104000
	 
	 

	 //sixth bit
	 
	 rx=1;
	 
	 #104000
	 
	 
	 
	 //seventh bit
	 
	 rx=1;
	 
	 #104000
	 
	 
	 
	 //eighth bit
	 
	 rx=1;
	 
	 #104000
	 
	 
	 
	 //parith bit
	 
	 rx=0;
	 
	 #104000	 
	 

	 
	 //stop bit
	 
	 rx=1;
	 
	 #10000	 
 //#############################################################

	 

	 
 //#######################second case########################## 

	 //idle state it can be removed as the lase bit is logic 1
	 
	 rx=1;
	 
	 #10
	 
	 
	 //start bit
	 
	 rx=0;
	 
	 #52000 
	 
	 
	 //data bits
	 
	 //firts bit
	 
	 rx=0;
	 
	 #104000

	 
	 //second bit
	 
	 rx=0;
	 
	 #104000
	 
	 
	 //third bit
	 
	 rx=0;
	 
	 #104000
	 
	 
	 //fourth bit
	 
	 rx=0;
	 
	 #104000
	 

	 //fifth bit
	 
	 rx=1;
	 
	 #104000
	 
	 

	 //sixth bit
	 
	 rx=1;
	 
	 #104000
	 
	 
	 
	 //seventh bit
	 
	 rx=1;
	 
	 #104000
	 
	 
	 
	 //eighth bit
	 
	 rx=1;
	 
	 #104000
	 
	 
	 
	 //parith bit
	 
	 rx=0;
	 
	 #104000	 
	 

	 
	 //stop bit
	 
	 rx=1;
	 
		 
 
 
 
 
 //#############################################################

	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 end
 
 
 
 endmodule 