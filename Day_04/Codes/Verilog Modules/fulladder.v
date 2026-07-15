`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2026 13:45:31
// Design Name: 
// Module Name: fulladder
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


module fulladder(a,b,cin,sum,carry);
input a,b,cin;
output sum,carry;
wire sum1,carry1,carry2;
halfadder ha1(a,b,sum1,carry1);
halfadder ha2(sum1,cin,sum,carry2);
or(carry,carry1,carry2);
endmodule
