
module key_shedule(clk,rst,key,s_boxed_row,out_key);
input clk,rst;
input [31:0] s_boxed_row;
input [127:0] key;
output [127:0] out_key;

wire [31:0] xor_output,xor_in1,xor_in2;
wire [31:0] in_1_1;
wire [31:0] in_2_1,in_2_2,in_2_3,in_2_4;
reg [2:0] counter;
reg [31:0] xor_output_new;

assign in_1_1 = xor_output_new;

assign in_2_1 = {key[12*8+7:12*8],key[8*8+7:8*8],key[(4)*8+7:4*8],key[0*8+7:0*8]};
assign in_2_2 = {key[(12+1)*8+7:(12+1)*8],key[(8+1)*8+7:(8+1)*8],key[(4+1)*8+7:(4+1)*8],key[(0+1)*8+7:(0+1)*8]};
assign in_2_3 = {key[(12+2)*8+7:(12+2)*8],key[(8+2)*8+7:(8+2)*8],key[(4+2)*8+7:(4+2)*8],key[(0+2)*8+7:(0+2)*8]};
assign in_2_4 = {key[(12+3)*8+7:(12+3)*8],key[(8+3)*8+7:(8+3)*8],key[(4+3)*8+7:(4+3)*8],key[(0+3)*8+7:(0+3)*8]};

assign sel_mux_2=(counter==1)?0:1;
mux2_1  #(32) mux2_1_1 (sel_mux_2,s_boxed_row,in_1_1,xor_in1);
mux_4_1 #(32) mux4_1_4 (counter[1:0],in_2_1,in_2_2,in_2_3,in_2_4,xor_in2);



assign xor_output=xor_in1^xor_in2;


register #(8) R1 (clk,rst,en1,xor_output[0*8+7:0*8],out_key[0*8+7:0*8]);
register #(8) R2 (clk,rst,en1,xor_output[1*8+7:1*8],out_key[4*8+7:4*8]);
register #(8) R3 (clk,rst,en1,xor_output[2*8+7:2*8],out_key[8*8+7:8*8]);
register #(8) R4 (clk,rst,en1,xor_output[3*8+7:3*8],out_key[12*8+7:12*8]);


register #(8) R5 (clk,rst,en2,xor_output[0*8+7:0*8],out_key[1*8+7:1*8]);
register #(8) R6 (clk,rst,en2,xor_output[1*8+7:1*8],out_key[5*8+7:5*8]);
register #(8) R7 (clk,rst,en2,xor_output[2*8+7:2*8],out_key[9*8+7:9*8]);
register #(8) R8 (clk,rst,en2,xor_output[3*8+7:3*8],out_key[13*8+7:13*8]);

register #(8) R9  (clk,rst,en3,xor_output[0*8+7:0*8],out_key[2*8+7:2*8]);
register #(8) R10 (clk,rst,en3,xor_output[1*8+7:1*8],out_key[6*8+7:6*8]);
register #(8) R11 (clk,rst,en3,xor_output[2*8+7:2*8],out_key[10*8+7:10*8]);
register #(8) R12 (clk,rst,en3,xor_output[3*8+7:3*8],out_key[14*8+7:14*8]);


register #(8) R13 (clk,rst,en4,xor_output[0*8+7:0*8],out_key[3*8+7:3*8]);
register #(8) R14 (clk,rst,en4,xor_output[1*8+7:1*8],out_key[7*8+7:7*8]);
register #(8) R15 (clk,rst,en4,xor_output[2*8+7:2*8],out_key[11*8+7:11*8]);
register #(8) R16 (clk,rst,en4,xor_output[3*8+7:3*8],out_key[15*8+7:15*8]);


assign en1=(counter==1)?1:0;
assign en2=(counter==2)?1:0;
assign en3=(counter==3)?1:0;
assign en4=(counter==4)?1:0;


always@(posedge clk , negedge rst)
    begin 
        if(!rst)
            begin 
            counter<=0;
            xor_output_new<=0;
            end
        else if(counter==5)
            begin
            counter=0;
            xor_output_new<=xor_output;
            end
        else 
            begin
            counter<=counter+1;
            xor_output_new<=xor_output;
            end
    end
endmodule
