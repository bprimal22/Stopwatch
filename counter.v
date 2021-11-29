`timescale 1ns / 1ps

module counter(
input startOrStop_button,
input reset,
input clk,
input decrement,
input load,
input [7:0] load_value,
output [3:0] s0, // Least significant digit
output [3:0] s1,
output [3:0] s2,
output [3:0] s3  // Most significant digit
    );
reg [3:0] s0_temp = decrement ? 9:0;
reg [3:0] s1_temp = decrement ? 9:0;
reg [3:0] s2_temp = decrement ? 9:0;
reg [3:0] s3_temp = decrement ? 9:0;

assign s0 = s0_temp;
assign s1 = s1_temp;
assign s2 = s2_temp;
assign s3 = s3_temp;

reg startOrStop = 0; // stores start of stop. 0 to stop and 1 to start
reg prev_startOrStop = 0;



always @(posedge clk)
begin
     if (startOrStop_button && !prev_startOrStop)
         startOrStop = ~startOrStop; 
     if (reset)
        begin
        if (load)
        begin
            s0_temp <= 0;
            s1_temp <= 0; 
            s2_temp = load_value[3:0] > 9 ? 9:load_value[3:0];
            s3_temp = load_value[7:4] > 9 ? 9:load_value[7:4];
        end
         else 
         begin
            s0_temp <= decrement ? 9:0;
            s1_temp <= decrement ? 9:0; 
            s2_temp <= decrement ? 9:0;
            s3_temp <= decrement ? 9:0;
        end
        end 
        else if (startOrStop == 1) // start counting
        begin
            if(decrement) begin
                if(s0_temp == 0) begin
                    s0_temp <= 9;
                        if (s1_temp == 0)
                            begin
                            s1_temp <= 9;
                            if (s2_temp == 0)
                                begin 
                                s2_temp <= 9;
                                if(s3_temp == 0)
                                    begin
                                    s0_temp <= 0;
                                    s1_temp <= 0;
                                    s2_temp <= 0;
                                    s3_temp <= 0;
                                    end
                                else
                                s3_temp <= s3_temp - 1;
                            end 
                            else
                                s2_temp <= s2_temp - 1;
                     end else
                        s1_temp <= s1_temp - 1; 
                end else
                    s0_temp <= s0_temp - 1;
            end else begin
                if(s0_temp == 9) begin
                    s0_temp <= 0;
                    if (s1_temp == 9) begin
                        s1_temp <= 0;
                        if (s2_temp == 9) begin 
                            s2_temp <= 0;
                            if(s3_temp == 9)
                                begin
                                s0_temp <= 9;
                                s1_temp <= 9;
                                s2_temp <= 9;
                                s3_temp <= 9;
                                end
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
         prev_startOrStop <= startOrStop_button;
end 
endmodule
