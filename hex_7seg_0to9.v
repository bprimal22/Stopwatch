`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2021 01:01:05 PM
// Design Name: 
// Module Name: hex_7seg_0to9
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


module hex_7seg_0to9(
    input [3:0] in,
    output [6:0] seg,
    output decimal
    );
    always @(*)
        case (in)
            4'b0000 : seg = 7'b0000001; // 0
            4'b0001 : seg = 7'b1001111; // 1
            4'b0010 : seg = 7'b0010010; // 2
            4'b0011 : seg = 7'b0000110; // 3
            4'b0100 : seg = 7'b1001100; // 4
            4'b0101 : seg = 7'b0100100; // 5
            4'b0110 : seg = 7'b0100000; // 6
            4'b0111 : seg = 7'b0001111; // 7
            4'b1000 : seg = 7'b0000000; // 8
            4'b1001 : seg = 7'b0000100; // 9
            default : seg = 7'b0000100; // 9
       endcase
    assign decimal = 4'b1111;
endmodule
