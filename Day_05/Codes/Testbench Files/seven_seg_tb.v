`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2026 14:52:30
// Design Name: 
// Module Name: seven_seg_tb
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


module seven_seg_tb();
reg [3:0]set;
wire a,b,c,d,e,f,g,h;

seven_seg dut(
    .set(set),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e),
    .f(f),
    .g(g),
    .h(h)
   );


integer i;   
initial begin
    for(i=0;i<10;i=i+1) begin
    set=i;
    #10;
    end; 
    $finish;
end
    
endmodule
