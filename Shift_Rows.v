
module Shift_Rows(clk,rst,data,OutData);
input clk,rst;
input         [127:0] data;
output  reg   [127:0] OutData;


wire [127:0] comb_data;

assign comb_data[0*8+7:0*8]=data[0*8+7:0*8];
assign comb_data[1*8+7:1*8]=data[1*8+7:1*8];
assign comb_data[2*8+7:2*8]=data[2*8+7:2*8];
assign comb_data[3*8+7:3*8]=data[3*8+7:3*8];

assign comb_data[4*8+7:4*8]=data[5*8+7:5*8];
assign comb_data[5*8+7:5*8]=data[6*8+7:6*8];
assign comb_data[6*8+7:6*8]=data[7*8+7:7*8];
assign comb_data[7*8+7:7*8]=data[4*8+7:4*8];

assign comb_data[8*8+7:8*8]  =data[10*8+7:10*8];
assign comb_data[9*8+7:9*8]  =data[11*8+7:11*8];
assign comb_data[10*8+7:10*8]=data[8*8+7:8*8];
assign comb_data[11*8+7:11*8]=data[9*8+7:9*8];

assign comb_data[12*8+7:12*8]=data[15*8+7:15*8];
assign comb_data[13*8+7:13*8]=data[12*8+7:12*8];
assign comb_data[14*8+7:14*8]=data[13*8+7:13*8];
assign comb_data[15*8+7:15*8]=data[14*8+7:14*8];

always@(posedge clk , negedge rst)
    begin 
        if(!rst)
            OutData<=0;
        else
            OutData<=comb_data;
    end

endmodule