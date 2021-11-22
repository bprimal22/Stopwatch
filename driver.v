`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2021 01:13:50 PM
// Design Name: 
// Module Name: driver
// Project Name: 
// Target Devices: 
// Target Devices: 
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


module driver(
    input clk,
    input reset,
    input start,
    input [9:0] sw,
    output [6:0] seg,
    output decimal,
    output S0_enable, //Least significant digit
    output S1_enable,
    output S2_enable,
    output S3_enable  //most significant digit
    );
    
wire clk_10ms;
wire clk_refresh;
reg [3:0] seg_in; //hex input to 7 seg
wire [3:0] s0; // value of LSD
wire [3:0] s1; 
wire [3:0] s2;
wire [3:0] s3;

clk_div CLK_DIV(
.clk(clk),
.clk_refresh(clk_refresh), 
.reset(reset),
.clk_10ms(clk_10ms)
);

counter COUNTER(
.startOrStop_button(start),
.reset(reset),
.clk(clk_10ms),
.s0(s0), // Least significant digit
.s1(s1),
.s2(s2),
.s3(s3)
);

digits_enable DIGITS(
.clk(clk_refresh), // clock to refresh
.S0_enable(S0_enable), //Least significant digit
.S1_enable(S1_enable),
.S2_enable(S2_enable),
.S3_enable(S3_enable)  //most significant 
);

hex_7seg_0to9 DISPLAY(
.in(seg_in),
.seg(seg),
.decimal(decimal)
 );
 
always @ (*)
case ({S0_enable,S1_enable,S2_enable,S3_enable})
    4'b1110: seg_in = s3;
    4'b1101: seg_in = s2;
    4'b1011: seg_in = s1;
    4'b0111: seg_in = s0;
    default: seg_in = 'b1111;  // F 
endcase 
endmodule
