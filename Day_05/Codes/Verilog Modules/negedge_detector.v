`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2026 17:06:30
// Design Name: 
// Module Name: negedge_detector
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


module negedge_detector(clk,sig,out);
input clk;
input sig;
output out;
reg sig_reg;

always@(posedge clk) begin
sig_reg <= sig;
end

assign out = ~sig & sig_reg;
endmodule