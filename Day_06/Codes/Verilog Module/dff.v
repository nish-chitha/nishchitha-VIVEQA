`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2026 17:20:48
// Design Name: 
// Module Name: dff
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

//this is done using mealy
module dff(
    input clk,
    input rst,
    input d,
    output reg q,
    output qb
);

always @(posedge clk)
begin
    if (rst)
        q <= 1'b0;
    else
        q <= d;
end

assign qb = ~q;

endmodule
