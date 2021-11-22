`timescale 1ns / 1ps

module digits_enable(
input clk, // clock to refresh
output S0_enable, //Least significant digit
output S1_enable,
output S2_enable,
output S3_enable  //most significant digit
    );


reg [3:0] on_off = 4'b1110; 

assign S0_enable = on_off[0]; //S0 on; everthing else off 
assign S1_enable = on_off[1]; 
assign S2_enable = on_off[2]; 
assign S3_enable = on_off[3]; 

always @(posedge clk) begin
  on_off <= {on_off[0],on_off[3:1]}; //shift the vector
end



endmodule
