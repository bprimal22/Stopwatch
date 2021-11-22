`timescale 1ns / 1ps

module clk_div(
input clk, 
input reset,
output clk_10ns
);

reg [26:0] count = 0;
reg temp_clk = 0;
assign clk_10ns = temp_clk;


always @(posedge clk) begin
  if (count < 10000000) begin //10,000,000 ns = 10 ms
    count <= count + 1;
  end
  else if (reset) begin
    count = 0;
  end
  else begin
    temp_clk <= ~temp_clk; 
    count <= 0;
  end
end
endmodule
