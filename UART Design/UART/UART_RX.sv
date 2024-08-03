
`timescale 1ns / 1ps


module UART_RX #(            
				parameter Data_bits=9,
				parameter Sp_ticks=16,//Stop_bit_ticks
				parameter St_ticks=8,//Start_bit_ticks
				parameter Dt_ticks=16//data ticks for received one data bit
       )
		 
		 (
                  
	          	input rx,
				input clk,Reset,
				input s_ticks,
				output logic rx_done_tick,
				output[Data_bits-2:0] data_out,
				output logic incorrect_send // if it equals logic one the data is correct ,if it equal to zero there is an error in the data that was received
				//output logic parity_bit;
		  
);


typedef enum {idle , start , data , parity , stop } S_states;


S_states state_reg ,state_next;//to keep track of next state

logic[$clog2(Dt_ticks)-1:0] s_reg,s_next;//to keep track of number of ticks

logic[$clog2(Data_bits)-1:0] n_reg,n_next; //to keep track of number of received bits

logic[Data_bits-2:0] sd_reg,sd_next; //data to be shifted 

logic parity_reg,parity_next;


always_ff@(posedge clk ,posedge Reset)
begin

    if(Reset)//reset is active high
	 
	   begin 
	 
	   state_reg<=idle;
		s_reg<=0;
		n_reg<=0;
		sd_reg<=0;
		parity_reg<=0;
		end
		
		
	 else begin
		   
		state_reg<=state_next;
		s_reg<=s_next;
		n_reg<=n_next;
		sd_reg<=sd_next;
		parity_reg<=parity_next;
		   end


end


always_comb
begin

    state_next=state_reg;
	 s_next=s_reg;
	 n_next=n_reg;
	 sd_next=sd_reg;
	 parity_next=parity_reg;
	 rx_done_tick=1'b0;
	 incorrect_send=0;

	 case(state_reg)
	        
			  idle:
			      begin
					if(~rx)begin
					   
						s_next=0;
						state_next=start;
						
					end
				      
					
			  end
			  
			  
			  
			  start:
			       begin
			    if(s_ticks)begin
				 
					if(s_next==St_ticks-1)begin
					   
						s_next=0;
						n_next=0;
						state_next=data;
						end
						
					else 
					   s_next=s_reg+1;
				      
				 end
			  end
			  
			  
			  
			  data:
			       begin
			    if(s_ticks)begin
				 
					if(s_next==Dt_ticks-1)begin
					
						sd_next={rx,sd_reg[Data_bits-2:1]};
						s_next=0;
						parity_next = parity_next ^ rx;
						
						
					
					  if(n_reg==Data_bits-2) begin
					      
					    	state_next=parity;
							//incorrect_send=(parity_reg==rx);
                                  end
						  
				     else
					    
						   n_next=n_reg+1;
				      
				     end
				 
					else
					
					   s_next=s_reg+1;
						
			    end
			  
			  end
			  parity: begin
					if(s_ticks)begin
				 
						if(s_next==Dt_ticks-1)begin
						
							//sd_next={rx,sd_reg[Data_bits-2:1]};
							s_next=0;
							parity_next = parity_next ^ rx;
							incorrect_send=(parity_reg==rx);
							//parity_bit=rx;
							state_next=stop;
									
						end else begin
						
							s_next=s_reg+1;
							// n_next=n_reg+1;
						
						end
				 
					
						
			    	end

			  end
			  
			  
			  
			  stop:
			       begin
			      
					if(s_ticks)begin

					   if(s_next==Sp_ticks-1)begin
						
						    state_next=idle;
						    rx_done_tick=1'b1; //receiving bits was successfully done
					    end
						 
						else
						 
						    s_next=s_reg+1;

						 
						   
				      
					
			  
			  
			        end
			  
			  end
			  
			  default:
			      
					state_next=idle;
					
					
   endcase
	

	
end


assign data_out=sd_reg;//receive the data bits


endmodule


