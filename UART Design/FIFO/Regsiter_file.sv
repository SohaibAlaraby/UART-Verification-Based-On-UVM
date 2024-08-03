`timescale 1ns / 1ps

module Regsiter_file #(

         parameter addr_width=5,
         parameter Data_bits=9

		   )
			(
			
			input clk,
			input w_en,
			input[Data_bits-1:0] w_data,
			input[addr_width-1:0] w_addr,r_addr,
			output[Data_bits-1:0] r_data
			
);




logic [Data_bits-1:0] reg_file [0:2**(addr_width)-1]; // modeling the regsiter file which represents memory




always_ff@(posedge clk)
begin 

         if(w_en)// if writing is enabled
			    reg_file[w_addr]<=w_data; // write the data at the regsiter file

end



assign r_data=reg_file[r_addr]; //read the date from the regsiter file



endmodule 