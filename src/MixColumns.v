
module MixColumns(clk,rst,data,OutData);
input          clk,rst;
input  [127:0] data;
output reg [127:0] OutData;

function [7:0] multiplyby2;
input [7:0] x;
 begin 
  if(x[7]==1) 
        multiplyby2=((x<<1)^8'b00011011);
  else    
        multiplyby2= x<<1;
 end
endfunction

function [7:0] multiplyby3;
input [7:0] x;
 begin 
   multiplyby3=multiplyby2(x)^x;
 end
endfunction

wire [127:0] comb_data;
genvar i;
generate
 for(i=0;i<4;i=i+1)
 begin 
   assign comb_data[i*8+7:i*8]=multiplyby2(data[i*8+7:i*8]) ^ multiplyby3(data[(4+i)*8+7:(4+i)*8]) ^ data[(8+i)*8+7:(8+i)*8] ^data[(12+i)*8+7:(12+i)*8] ;
   assign comb_data[(4+i)*8+7:(4+i)*8]=data[i*8+7:i*8] ^ multiplyby2(data[(4+i)*8+7:(4+i)*8]) ^  multiplyby3(data[(8+i)*8+7:(8+i)*8]) ^  data[(12+i)*8+7:(12+i)*8] ;
   assign comb_data[(8+i)*8+7:(8+i)*8]=data[i*8+7:i*8] ^ data[(4+i)*8+7:(4+i)*8] ^ multiplyby2(data[(8+i)*8+7:(8+i)*8]) ^ multiplyby3(data[(12+i)*8+7:(12+i)*8]); 
   assign comb_data[(12+i)*8+7:(12+i)*8]=multiplyby3(data[i*8+7:i*8]) ^ data[(4+i)*8+7:(4+i)*8] ^ data[(8+i)*8+7:(8+i)*8] ^ multiplyby2(data[(12+i)*8+7:(12+i)*8]); 
 end
endgenerate

always@(posedge clk , negedge rst)
    begin 
        if(!rst)
            OutData<=0;
        else
            OutData<=comb_data;
    end

endmodule
