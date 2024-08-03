`timescale 1ns / 1ps

module FIFO #(

              parameter addr_width=5,
              parameter Data_bits=9,
	      parameter Read=2'b01,
	      parameter Write=2'b10,
	      parameter Read_and_Write=2'b11
					
            )
				(
				
				  input clk,Reset,
				  input wr,rd,
				  input[Data_bits-1:0] w_data,
				  output logic full,empty,
				  output[Data_bits-1:0] r_data
				
);



//intermediate signals declaration

logic[addr_width-1:0] w_addr,r_addr;

logic w_en;


assign w_en= wr&(~full);





//initialize fifo control unit   
FIFO_Contr #( .addr_width(addr_width), .Read(Read), .Write(Write), .Read_and_Write(Read_and_Write))

         controller
			
	(                               .clk(clk),
					.Reset(Reset) ,
					.wr(wr),
					.rd(rd) ,
					.full(full) ,
					.empty(empty),
					.w_addr(w_addr),
					.r_addr(r_addr) );
 
 

 
 
 
//initialize regsiter file   
Regsiter_file #(.addr_width(addr_width), .Data_bits(Data_bits)) 

         reg_file
			
	(                        .clk(clk),
				 .w_en(w_en) ,
				 .w_data(w_data),
				 .w_addr(w_addr),
				 .r_addr(r_addr),
				 .r_data(r_data) );





endmodule 

