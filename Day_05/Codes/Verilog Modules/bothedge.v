`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.06.2026 18:25:29
// Design Name: 
// Module Name: bothedge
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


module bothedge(clk, sig, pos_out, neg_out);
    input  clk;
    input  sig;
    output pos_out;   // pulses on rising edge
    output neg_out;   // pulses on falling edge
     

    reg signal_reg;

    always @(posedge clk) begin
        signal_reg <= sig;
    end

    assign pos_out =  sig & ~signal_reg;   // 0?1
    assign neg_out = ~sig &  signal_reg;   // 1?0
endmodule