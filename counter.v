`timescale 1ns / 1ps

module counter(
input startOrStop_button,
input reset,
input clk,
output [3:0] s0, // Least significant digit
output [3:0] s1,
output [3:0] s2,
output [3:0] s3  // Most significant digit
    );
reg [3:0] s0_temp = 0;
reg [3:0] s1_temp = 0;
reg [3:0] s2_temp = 0;
reg [3:0] s3_temp = 0;

assign s0 = s0_temp;
assign s1 = s1_temp;
assign s2 = s2_temp;
assign s3 = s3_temp;

reg startOrStop = 0; // stores start of stop. 0 to stop and 1 to start

always @ (posedge startOrStop_button)
    begin
         startOrStop <= ~startOrStop; 
    end

always @(posedge clk)
begin
     if (reset)
        begin 
            s0_temp <= 0;
            s1_temp <= 0;
            s2_temp <= 0;
            s3_temp <= 0;

        end else if (startOrStop == 1) // start counting
        begin
          if(s0_temp == 9)
          begin
             s0_temp <= 0;
             if (s1_temp == 9)
                 begin
                    s1_temp <= 0;
                    if (s2_temp == 9)
                        begin 
                            s2_temp <= 0;
                            if(s3_temp == 9)
                                s3_temp <= 0;
                            else
                                s3_temp <= s3_temp + 1;
                        end else
                            s2_temp <= s2_temp + 1;
                 end else
                     s1_temp <= s1_temp + 1; 
          end else
            s0_temp <= s0_temp + 1;
         end
end
    
endmodule
