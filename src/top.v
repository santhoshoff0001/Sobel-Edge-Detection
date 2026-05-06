module top(
    input clk,
    input rst,
    input [7:0] pixel_in,
    output [7:0] edge_out
);

wire [7:0] p0,p1,p2,p3,p4,p5,p6,p7,p8;

line_buffer lb(
    .clk(clk),
    .rst(rst),
    .pixel_in(pixel_in),
    .p0(p0),.p1(p1),.p2(p2),
    .p3(p3),.p4(p4),.p5(p5),
    .p6(p6),.p7(p7),.p8(p8)
);

sobel_core sc(
    .clk(clk),
    .rst(rst),
    .p0(p0),.p1(p1),.p2(p2),
    .p3(p3),.p4(p4),.p5(p5),
    .p6(p6),.p7(p7),.p8(p8),
    .edge_out(edge_out)
);

endmodule
