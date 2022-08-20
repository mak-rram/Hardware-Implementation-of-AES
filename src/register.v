`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2022 03:13:52 PM
// Design Name: 
// Module Name: register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register #(parameter N=8) (clk,rst,en,in,out);
input      clk,rst,en;
input      [N-1:0] in;
output reg [N-1:0] out;

always@(posedge clk, negedge rst)
  begin 
    if(!rst)
        out<=0;
    else if(en)
        out<=in;
    else 
        out<=out;
  end

endmodule
