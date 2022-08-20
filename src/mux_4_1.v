

module mux_4_1 #(parameter N = 8) (sel,in1,in2,in3,in4,out);
input [1:0] sel;
input [N-1:0] in1,in2,in3,in4;
output reg [N-1:0] out;

always@(sel,in1,in2,in3,in4)
 begin
  case(sel)
     2'b00   :       out = in4;
     2'b01   :       out = in1;
     2'b10   :       out = in2;
     2'b11   :       out = in3;
     default :       out = in3;
  endcase
 end

endmodule
