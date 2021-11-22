`timescale 1ns / 1ps

module clk_div(
input clk, 
input reset,
output clk_10ms,
output clk_refresh
);

reg [31:0] count = 0;
reg [15:0] refresh_count = 0;
assign clk_refresh = refresh_count[15];
reg ms_clk = 0;
assign clk_10ms = ms_clk;


always @(posedge clk) begin
  ms_clk <= 0;
  if (reset)begin
    count <= 0;
    refresh_count = 0;
  end
  if (count < 1000000) begin //1,000,000 ns = 10 ms
    count <= count + 1;
  end
  else begin
    ms_clk <= 1; 
    count <= 0;
  end
  refresh_count = refresh_count + 1; 
  
end
endmodule
