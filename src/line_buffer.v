module line_buffer(
    input clk,
    input rst,
    input [7:0] pixel_in,
    output reg [7:0] p0,p1,p2,
    output reg [7:0] p3,p4,p5,
    output reg [7:0] p6,p7,p8
);

parameter WIDTH = 256;

reg [7:0] line1 [0:WIDTH-1];
reg [7:0] line2 [0:WIDTH-1];

reg [8:0] col;

integer i;

always @(posedge clk) begin
    if(rst) begin
        col <= 0;
        for(i=0;i<WIDTH;i=i+1) begin
            line1[i] <= 0;
            line2[i] <= 0;
        end
        p0<=0; p1<=0; p2<=0;
        p3<=0; p4<=0; p5<=0;
        p6<=0; p7<=0; p8<=0;
    end
    else begin
        // Shift vertical lines
        line2[col] <= line1[col];
        line1[col] <= pixel_in;

        // Horizontal window shift
        p0 <= p1;
        p1 <= p2;
        p2 <= line2[col];

        p3 <= p4;
        p4 <= p5;
        p5 <= line1[col];

        p6 <= p7;
        p7 <= p8;
        p8 <= pixel_in;

        // Column counter
        if(col == WIDTH-1)
            col <= 0;
        else
            col <= col + 1;
    end
end

endmodule