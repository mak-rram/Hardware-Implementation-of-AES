

module RCON(
    input [3:0] in,
    output [7:0] out
    );
 wire [7:0] mem [9:0];
 
 assign out = mem[in-1];
 
 assign mem[0] =  8'h01;
 assign mem[1] =  8'h02;
 assign mem[2] =  8'h04;
 assign mem[3] =  8'h08;
 assign mem[4] =  8'h10;
 assign mem[5] =  8'h20;
 assign mem[6] =  8'h40;
 assign mem[7] =  8'h80;
 assign mem[8] =  8'h1b;
 assign mem[9] =  8'h36;
  
endmodule
