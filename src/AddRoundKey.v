module AddRoundKey(clk,rst,key,data,outdata);
input clk,rst ;
input         [127:0] key,data;
output  reg   [127:0] outdata;

wire [127:0] comb_data;
assign comb_data= key^data;


always@(posedge clk , negedge rst)
    begin 
        if(!rst)
            outdata<=0;
        else
            outdata<=comb_data;
    end


/*
genvar i;
    for(i=0;i<16;i=i+1)
        assign comb_data[i*8+7:i*8]=key[i*8+7:i*8]^data[i*8+7:i*8];
  */ 
endmodule



