
`timescale 1ns / 1ps

module UART_TX #(  
		parameter Data_bits=9, //including parity bit
		parameter Sp_ticks=16, //Stop_bit_ticks
		parameter St_ticks=8,  //Start_bit_ticks
		parameter Dt_ticks=16 //data ticks for transimting one data bit
      ) 
		
		(

                 input clk,Reset,
		 input[Data_bits-2:0] data_in,
		 input tx_start,
		 input s_ticks,
		 output logic tx_done_tick,
		 output logic parity_check,
		 output logic tx

);

typedef enum  { idle , start , data , stop }  S_states;


S_states state_reg ,state_next; //to keep track of next state

logic tx_reg ,tx_next; //to keep track of transmitted data bit

logic[$clog2(Dt_ticks)-1:0] s_reg ,s_next; //to keep track of number of ticks

logic[$clog2(Data_bits)-1:0] n_reg ,n_next; //to keep track of number of transmitted bits

logic[Data_bits-2:0] sd_reg,sd_next; //data to be shifted 

logic parity_reg,parity_next; //parity check bit

always_ff@(posedge clk,posedge Reset )

begin

if(Reset) //reset is active high
begin
    state_reg<=idle;
    tx_reg<=0;
	 s_reg<=0;
	 n_reg<=0;
	 sd_reg<=0;
	 parity_reg<=0; //will change if the number of bits is odd

	 
end

else begin



    state_reg<=state_next;
	 s_reg<=s_next;
	 n_reg<=n_next;
	 sd_reg<=sd_next;
	 parity_reg<=parity_next;
	 
	 if(n_reg==Data_bits-1)
	     tx_reg<=parity_check;
	  else
	     tx_reg<=tx_next;


	 
end


end


always_comb

begin

    state_next=state_reg;
	 s_next=s_reg;
	 n_next=n_reg;
	 sd_next=sd_reg;
    tx_next=tx_reg;
	 parity_next=parity_reg;
	 tx_done_tick=1'b0;
    parity_check=1'b0;

   case(state_reg)
        
		idle:
		     begin
			  
		       tx_next=1'b1;
				 
				 if(tx_start)begin
				  
		        s_next=0;
				  sd_next=data_in;
				  state_next=start;
		
		       end		
		
		end
		
		start:
		      begin
		       tx_next=1'b0;
				 
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
		       tx_next=sd_reg[0];
				 
				 if(s_ticks)begin
				  
				  if(s_next==Dt_ticks-1)begin
		          s_next=0;
				    sd_next=sd_reg>>1;
					
					
					 if(n_reg==Data_bits-1)begin
					  n_next=0;
					  state_next=stop;
					  end
					
					 else begin
					  n_next=n_reg+1;
				     parity_next = parity_next ^ tx_next;
					  if(n_reg==Data_bits-2)
					     parity_check=parity_next;

					 end
					
				  end
				  
		        else 
				  s_next=s_reg+1;
				  
		       end
	   
		 end
		
		stop:
		    begin
		   tx_next=1'b1; 
				 if(s_ticks)begin
				  
				  if(s_next==Sp_ticks-1)begin
		          tx_done_tick=1'b1;//transmissions was successfully done
				    state_next=idle;
					
				    end
				  
		        else 
				    s_next=s_reg+1;
				  
		       end
		
		   end
			
		default:
         
			state_next=idle;

   endcase

end


assign tx=tx_reg; //transmit the data bit




endmodule




