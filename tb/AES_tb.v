`timescale 1ns / 1ps


module AES_tb(

    );


reg clk,rst;
reg [127:0] data,key;
wire [127:0] out;
reg start;
wire done;
AES AES(clk,rst,data,key,out,start,done);

initial 
 begin 
 clk=0;
  rst=1;
  key=128'h3C_88_A6_16_4F_15_D2_15_CF_F7_AE_7E_09_AB_28_2B;
  data=128'h34_a2_8d_a8_07_98_30_f6_37_31_5a_43_e0_31_88_32;
  #7.5;
  rst=0;
  #5;
  rst=1;
  start=1;
 #5;
 start=0;
 #507;
$display("output = ");
$display("8h%h 8h%h 8h%h 8h%h", out[8*0+7:8*0]  ,out[8*1+7:8*1],out[8*2+7:8*2],out[8*3+7:8*3]);
$display("8h%h 8h%h 8h%h 8h%h", out[8*4+7:8*4]  ,out[8*5+7:8*5],out[8*6+7:8*6],out[8*7+7:8*7]);
$display("8h%h 8h%h 8h%h 8h%h", out[8*8+7:8*8]  ,out[8*9+7:8*9],out[8*10+7:8*10],out[8*11+7:8*11]);
$display("8h%h 8h%h 8h%h 8h%h", out[8*12+7:8*12],out[8*13+7:8*13],out[8*14+7:8*14],out[8*15+7:8*15]);
 end 

always #2.5 clk=~clk;

endmodule
