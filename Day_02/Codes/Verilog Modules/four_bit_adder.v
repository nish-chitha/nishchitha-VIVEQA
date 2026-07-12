`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2026 13:57:12
// Design Name: 
// Module Name: four_bit_adder
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


module four_bit_adder(a,b,sum,carry);
input [3:0]a,b;
output [3:0]sum;
output carry;

wire c1,c2,c3;
fulladder fa1(a[0],b[0],1'b0,sum[0],c1);
fulladder fa2(a[1],b[1],c1,sum[1],c2);
fulladder fa3(a[2],b[2],c2,sum[2],c3);
fulladder fa4(a[3],b[3],c3,sum[3],carry);

endmodule