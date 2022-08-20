module clock_gating (CLK_EN,clk,rst,GATED_CLK);
input      CLK_EN;
input      clk,rst;
output     GATED_CLK;
//internal connections
reg   flag;

//latch (Level Sensitive Device)
always @(posedge clk or negedge rst)
 begin
	if (!rst)
		flag<=1'b0;
	else if (CLK_EN)
		flag<=1'b1;
	else
		flag<=1'b0;		
 end 
// ANDING
assign  GATED_CLK = clk && flag ;

endmodule