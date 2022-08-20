module SubByte(clk,rst,data,OutData,key_in,key_out,R_CON,uncomplete_Key_Shedule_flag,SubByte_flag);
input           clk,rst;
input   [31:0]  key_in;
input   [7:0]   R_CON;
input   [127:0] data;
output SubByte_flag;
output  [127:0] OutData;
output   [31:0]  key_out;
output uncomplete_Key_Shedule_flag;

wire [7:0] sbox01_in,sbox1_out,sbox02_in,sbox2_out;
wire [7:0] sbox03_in,sbox3_out,sbox04_in,sbox4_out;
wire [7:0] sbox1_in,sbox2_in,sbox3_in,sbox4_in;

wire [2:0] mux1_sel ;
assign mux1_sel = counter - 1;
mux_4_1 #(8) mux4_1_1 (mux1_sel[1:0],data[0*8+7:0*8],data[1*8+7:1*8],data[2*8+7:2*8],data[3*8+7:3*8],sbox01_in);
mux_4_1 #(8) mux4_1_2 (mux1_sel[1:0],data[4*8+7:4*8],data[5*8+7:5*8],data[6*8+7:6*8],data[7*8+7:7*8],sbox02_in);
mux_4_1 #(8) mux4_1_3 (mux1_sel[1:0],data[8*8+7:8*8],data[9*8+7:9*8],data[10*8+7:10*8],data[11*8+7:11*8],sbox03_in);
mux_4_1 #(8) mux4_1_4 (mux1_sel[1:0],data[12*8+7:12*8],data[13*8+7:13*8],data[14*8+7:14*8],data[15*8+7:15*8],sbox04_in);

assign mux2_sel = (counter==1)?1:0;
mux2_1 #(.N(8)) mux2_1_1 (mux2_sel,sbox01_in,key_in[0*8+7:0*8],sbox1_in);
mux2_1 #(.N(8)) mux2_1_2 (mux2_sel,sbox02_in,key_in[1*8+7:1*8],sbox2_in);
mux2_1 #(.N(8)) mux2_1_3 (mux2_sel,sbox03_in,key_in[2*8+7:2*8],sbox3_in);
mux2_1 #(.N(8)) mux2_1_4 (mux2_sel,sbox04_in,key_in[3*8+7:3*8],sbox4_in);


s_box sbox1(sbox1_in,sbox1_out);
s_box sbox2(sbox2_in,sbox2_out);
s_box sbox3(sbox3_in,sbox3_out);
s_box sbox4(sbox4_in,sbox4_out);




register #(8) R1 (clk,rst,en2,sbox1_out,OutData[0*8+7:0*8]);
register #(8) R2 (clk,rst,en2,sbox2_out,OutData[4*8+7:4*8]);
register #(8) R3 (clk,rst,en2,sbox3_out,OutData[8*8+7:8*8]);
register #(8) R4 (clk,rst,en2,sbox4_out,OutData[12*8+7:12*8]);


register #(8) R5 (clk,rst,en3,sbox1_out,OutData[1*8+7:1*8]);
register #(8) R6 (clk,rst,en3,sbox2_out,OutData[5*8+7:5*8]);
register #(8) R7 (clk,rst,en3,sbox3_out,OutData[9*8+7:9*8]);
register #(8) R8 (clk,rst,en3,sbox4_out,OutData[13*8+7:13*8]);

register #(8) R9  (clk,rst,en4,sbox1_out,OutData[2*8+7:2*8]);
register #(8) R10 (clk,rst,en4,sbox2_out,OutData[6*8+7:6*8]);
register #(8) R11 (clk,rst,en4,sbox3_out,OutData[10*8+7:10*8]);
register #(8) R12 (clk,rst,en4,sbox4_out,OutData[14*8+7:14*8]);


register #(8) R13 (clk,rst,en5,sbox1_out,OutData[3*8+7:3*8]);
register #(8) R14 (clk,rst,en5,sbox2_out,OutData[7*8+7:7*8]);
register #(8) R15 (clk,rst,en5,sbox3_out,OutData[11*8+7:11*8]);
register #(8) R16 (clk,rst,en5,sbox4_out,OutData[15*8+7:15*8]);

register #(8) R17 (clk,rst,en1,sbox2_out^R_CON,key_out[0*8+7:0*8]);
register #(8) R18 (clk,rst,en1,sbox3_out,      key_out[1*8+7:1*8]);
register #(8) R19 (clk,rst,en1,sbox4_out,      key_out[2*8+7:2*8]);
register #(8) R20 (clk,rst,en1,sbox1_out,      key_out[3*8+7:3*8]);




assign en1=(counter==1)?1:0;
assign en2=(counter==2)?1:0;
assign en3=(counter==3)?1:0;
assign en4=(counter==4)?1:0;
assign en5=(counter==5)?1:0;
assign SubByte_flag=(counter==6)?1:0;
assign uncomplete_Key_Shedule_flag = en2;

reg [2:0] counter;
always@(posedge clk , negedge rst)
    begin 
        if(!rst)
            counter<=0;
        else if(counter==6)
            counter=0;
        else 
            counter<=counter+1;
    end
endmodule