
module mux2_1 #(parameter N = 8) (sel,in1,in2,out);
input sel;
input [N-1:0] in1,in2;
output reg [N-1:0] out;

always@(*)
 begin
  case(sel)
     1'b0   :       out = in1;
     1'b1   :       out = in2;
     default :      out = in2;
  endcase
 end

endmodule
