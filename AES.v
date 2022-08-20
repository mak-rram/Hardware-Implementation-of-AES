
module AES(clk,rst,data,key,out,start,done);
input clk,rst;
input [127:0] data,key;
output reg [127:0] out;
input start;
output wire done;


	  
wire [3:0] counter ;
reg [127:0] KS_mem;
always @(posedge clk , negedge rst)
begin
 if(!rst) 
    begin
		KS_mem             <= 0;
		AddRoundKey_data   <= 0;
		out                <= 0;
	end
 else
	begin
		if (start)
				KS_mem  <= key;
		else if (key_shedule_flag)
				KS_mem  <= KS_key_out;
		else 
				KS_mem  <= KS_mem; 
		
		if  (counter == 10)
	        AddRoundKey_data           <=   SR_OutData  ;
		else if(counter == 0)
		    AddRoundKey_data           <=   data  ;
		else                       
		    AddRoundKey_data           <=   MC_OutData  ;
			
		if(done)
		    out                		   <=   AddRoundKey_dataout;
		else 
			out                		   <=   out;
	end 
end 






//1 AddRoundKey
reg  [127:0] AddRoundKey_data;
wire [127:0] AddRoundKey_dataout;
wire GATED_CLK_XOR;
AddRoundKey AddRoundKey1(GATED_CLK_XOR,rst,KS_mem,AddRoundKey_data,AddRoundKey_dataout);

//2 RCON,SubByte
wire [7:0] RCON_OUT;
RCON RCON(counter,RCON_OUT);
wire [127:0] SubByte_OutData;
wire [31:0]   SubByte_key_in;
assign SubByte_key_in = {KS_mem[15*8+7:15*8],KS_mem[11*8+7:11*8],KS_mem[7*8+7:7*8],KS_mem[3*8+7:3*8]};
wire [31:0]  SubByte_key_out;
wire uncomplete_Key_Shedule_flag,SubByte_flag;
wire SBOX_RST;
wire GATED_CLK_SBOX;
SubByte SubByte1(GATED_CLK_SBOX,SBOX_RST,AddRoundKey_dataout,SubByte_OutData,SubByte_key_in,SubByte_key_out,RCON_OUT,uncomplete_Key_Shedule_flag,SubByte_flag);

//3 Shift_Rows
wire [127:0]  SR_OutData;
wire GATED_CLK_SR;
Shift_Rows Shift_Rows1 (GATED_CLK_SR,rst,SubByte_OutData,SR_OutData);


//4 MixColumns
wire [127:0]  MC_OutData;
wire GATED_CLK_MC;
MixColumns MixColumns1 (GATED_CLK_MC,rst,SR_OutData,MC_OutData);





//5 key_shedule
wire 		GATED_CLK_KS;
wire [127:0] KS_key_out;
wire key_shedule_flag;
wire KS_RST; 
key_shedule key_shedule1 (GATED_CLK_KS,rst,KS_mem,SubByte_key_out,KS_key_out,key_shedule_flag);


//clock gating 
wire  SBOX_EN;
clock_gating for_sbox(SBOX_EN,clk,rst,GATED_CLK_SBOX);
wire  XOR_EN;
clock_gating for_xor(XOR_EN,clk,rst,GATED_CLK_XOR);
wire  SR_EN;
clock_gating for_SR(SR_EN,clk,rst,GATED_CLK_SR);
wire  MC_EN;
clock_gating for_MC(MC_EN,clk,rst,GATED_CLK_MC);
wire  KS_EN;
clock_gating for_KS(KS_EN,clk,rst,GATED_CLK_KS);

//controller
FSM_controller  FSM_controller (clk,rst,start,uncomplete_Key_Shedule_flag,SubByte_flag,SBOX_EN,SBOX_RST,XOR_EN,SR_EN,MC_EN,KS_EN,KS_RST,done,counter);


endmodule
