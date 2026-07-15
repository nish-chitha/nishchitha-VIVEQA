`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2026 18:26:34
// Design Name: 
// Module Name: bothedge_tb
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

module bothedge_tb;
    reg  sig;
    reg  clk;
    wire pos_out;
    wire neg_out;

    bothedge dut (
        .sig(sig),
        .clk(clk),
        .pos_out(pos_out),
        .neg_out(neg_out)
       
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        sig = 0;
        #7 sig = 1;
        #10 sig = 0;
        #10 sig = 1;
        #10 sig = 0;  
        #20 $finish;
    end

endmodule
