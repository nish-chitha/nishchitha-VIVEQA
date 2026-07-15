`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2026 17:15:50
// Design Name: 
// Module Name: negedge_detector_tb
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


module negedge_detector_tb;
	reg sig;         
	reg clk;
	wire out;         
	negedge_detector dut (  .sig(sig),
    					 .clk(clk),
 			      		 .out(out));
	always #5 clk = ~clk;
	initial begin
		clk <= 0;
		sig <= 1;
		#15 sig <= 0;
		#20 sig <= 1;
		#15 sig <= 0;
		#10 sig <= 1;
		#20 $finish;
	end
endmodule
