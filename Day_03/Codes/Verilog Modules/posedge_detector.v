`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2026 16:30:36
// Design Name: 
// Module Name: posedge_detector
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


module posedge_detector(clk,sig,out);
input clk;
input sig;
output out;
reg signal_reg;
always@(posedge clk) begin
signal_reg<=sig;
end

assign out= sig & ~signal_reg;
endmodule


