`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2026 15:29:21
// Design Name: 
// Module Name: jkflipflop
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


module jkflipflop(clk,rst,j,k,q,qb);
input clk,rst;
input j,k;
output reg q; //always @ is used
output qb;  //because assign is used
always@(posedge clk) begin
if(rst)
    q<=1'b0;
else begin
    case({j,k})
    2'b00:q<=q;
    2'b01:q<=1'b0;
    2'b10:q<=1'b1;
    2'b11:q<=~q;
    endcase
 end
 end
 assign qb=~q;
 
endmodule
