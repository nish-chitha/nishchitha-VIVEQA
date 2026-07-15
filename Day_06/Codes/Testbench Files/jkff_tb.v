`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2026 15:49:41
// Design Name: 
// Module Name: jkff_tb
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

`timescale 1ns/1ps

module jkflipflop_tb;

reg clk;
reg rst;
reg j;
reg k;

wire q;
wire qb;

// Instantiate the DUT
jkflipflop uut (
    .clk(clk),
    .rst(rst),
    .j(j),
    .k(k),
    .q(q),
    .qb(qb)
);

// Clock generation (10 ns period)
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Stimulus
initial begin
    // Initialize
    rst = 1;
    j = 0;
    k = 0;
    // Keep reset active for one clock edge
    #12;
    rst = 0;
    // 00 -> Hold
    j = 0;
    k = 0;
    #10;
    // 10 -> Set
    j = 1;
    k = 0;
    #10;
    // 00 -> Hold
    j = 0;
    k = 0;
    #10;
    // 01 -> Reset
    j = 0;
    k = 1;
    #10;
    // 11 -> Toggle
    j = 1;
    k = 1;
    #10;
    // Toggle again
    j = 1;
    k = 1;
    #10;
    // Set
    j = 1;
    k = 0;
    #10;
    // Reset
    j = 0;
    k = 1;
    #10;
    // Hold
    j = 0;
    k = 0;
    #10;
    $finish;
end

// Monitor values
initial begin
    $monitor("Time=%0t clk=%b rst=%b J=%b K=%b Q=%b QB=%b",
             $time, clk, rst, j, k, q, qb);
end

endmodule