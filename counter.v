`timescale 1ns / 1ps

module counter(
input startOrStop,
input reset,
input clk,
output reg [3:0] s0, // Least significant digit
output reg [3:0] s1,
output reg [3:0] s2,
output reg [3:0] s3  // Most significant digit
    );

reg temp_startOrStop = 0; // stores start of stop. 0 to stop and 1 to start

always @ (posedge clk)
    begin
        if (startOrStop)
                temp_startOrStop <= ~temp_startOrStop; 
    end

always @(posedge clk)
begin
     if (reset)
        begin 
            s0 <= 0;
            s1 <= 0;
            s2 <= 0;
            s3 <= 0;

        end else if (temp_startOrStop == 0) // store old count
        begin
            s0 <= s0;
            s1 <= s1;
            s2 <= s2; 
            s3 <= s3;
        end else if (temp_startOrStop == 1) // start counting
        begin
          if(s0 == 9)
          begin
             s0 <= 0;
             if (s1 == 9)
                 begin
                    s1 <= 0;
                    if (s2 == 9)
                        begin 
                            s2 <= 0;
                            if(s3 == 9)
                                s3 <= 0;
                            else
                                s3 <= s3 + 1;
                        end else
                            s2 <= s2 + 1;
                 end else
                     s1 <= s1 + 1; 
          end else
            s0 <= s0 + 1;
         end
end
    
endmodule
