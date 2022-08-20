module FSM_controller (clk,rst,start,uncomplete_Key_Shedule_flag,SubByte_flag,SBOX_EN,SBOX_RST,XOR_EN,SR_EN,MC_EN,KS_EN,KS_RST,done,counter);
input clk,rst;
input start;
input uncomplete_Key_Shedule_flag;
input SubByte_flag;
output reg SBOX_EN ;
output reg SBOX_RST;
output reg XOR_EN  ;
output reg SR_EN   ;
output reg MC_EN   ;
output reg KS_EN   ;
output reg KS_RST  ;
output reg done    ; 
output reg [3:0] counter;   










reg [2:0] current_state,next_state;
parameter IDLE        = 3'b000,
          AddRoundKey = 3'b001,
          SubByte     = 3'b011,
		  Shift_Rows  = 3'b010,
		  MixColumns  = 3'b110,
		  key_shedule = 3'b100,
		  DONE        = 3'b101;



always @(posedge clk , negedge rst)
begin
 if(!rst) 
    begin
		current_state      <= IDLE;// when reset=0, reset the state of the FSM to "IDLE" Stat
		counter 	       <= 0;
	end
 else
	begin
		current_state <= next_state; // otherwise, next state

        if(XOR_EN)
			counter <= counter + 1;
        else if(start)
		    counter <= 0;
		else 		
            counter <= counter;		
		
	end 
end 




//signal assign 
always @(*)
begin
 case(current_state) 
 
 IDLE:begin
    if(start) 
      next_state               <=  AddRoundKey  ;
    else                      
      next_state               <=  current_state;
    SBOX_EN                    <=  0            ;
    SBOX_RST                   <=  1            ;
    XOR_EN                     <=  0            ;
    SR_EN                      <=  0            ;
    MC_EN                      <=  0            ;
    KS_EN                      <=  0            ;
    KS_RST                     <=  1            ;
    done                       <=  0            ;
 end
 
 
 AddRoundKey:begin
    if     (counter == 10)
			next_state         <=   DONE        ;
	else if(counter == 0)                       
			next_state         <=   SubByte     ;
	else                                        
			next_state         <=   SubByte     ;
	    
	
	SBOX_EN                    <=   0			;
	SBOX_RST                   <=   0			;
	XOR_EN                     <=   1			;
	SR_EN                      <=   0			;
	MC_EN                      <=   0			;
	KS_EN                      <=   0			;
	KS_RST                     <=   0			;
	done                       <=   0			;
 end
 SubByte:begin
	
	SBOX_RST                   <=   1			;
	XOR_EN                     <=   0			;
	MC_EN                      <=   0			;
	KS_RST                     <=   1			;
	done                       <=   0			;

	if(uncomplete_Key_Shedule_flag || KS_EN)
		begin 
			KS_EN              <=   1           ;
		end
	else 
	        KS_EN              <=   0           ;
		
	if(SubByte_flag)
	    begin 
			next_state         <=   Shift_Rows  ;
			SBOX_EN            <=   0           ;
			SR_EN              <=   1           ;
		end
	else 
		 begin 
	    	next_state         <=  current_state;
	    	SBOX_EN            <=   1           ;
	    	SR_EN              <=   0           ;
        end
 end
 Shift_Rows:begin
	if(counter != 10)
	    next_state    		   <=   MixColumns  ;
	else		                                
	   next_state     		   <=   AddRoundKey ;
	
	SBOX_EN                    <=   0   	    ;
	XOR_EN                     <=   0			;
	SBOX_RST                   <=   1   		;
	SR_EN                 	   <=   1   		;
	MC_EN                      <=   0   		;
	done                       <=   0   		;
	KS_RST                     <=   1   		;
	KS_EN                      <=   0   		;
 end
 
 MixColumns:begin
	next_state                 <=   AddRoundKey ;
	SBOX_EN                    <=   0    		;
	XOR_EN                     <=   0			;
	SBOX_RST                   <=   1    		;
	SR_EN                 	   <=   0    		;
	MC_EN                      <=   1    		;
	done                       <=   0    		;
	KS_RST	 	               <=   1   	    ;
	KS_EN                      <=   0    		;

 end 
 
 DONE:begin
	next_state                 <=   IDLE 		;
	SBOX_EN                    <=   0    		;
	XOR_EN                     <=   0			;
	SBOX_RST                   <=   1    		;
	SR_EN                 	   <=   0    		;
	MC_EN                      <=   1    		;
	done                       <=   1    		;
	KS_RST	 	               <=   1    		;
	KS_EN                      <=   0    		;
 	end
 default: 
    begin 
	next_state                 <=   IDLE 		;
	SBOX_EN                    <=   0    		;
	XOR_EN                     <=   0			;
	SBOX_RST                   <=   1    		;
	SR_EN                 	   <=   0    		;
	MC_EN                      <=   1    		;
	done                       <=   1    		;
	KS_RST	 	               <=   1    		;
	KS_EN                      <=   0    		;
	end
 endcase 
end

endmodule