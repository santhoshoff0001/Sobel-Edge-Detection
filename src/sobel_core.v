module sobel_core(
    input clk,
    input rst,
    input [7:0] p0,p1,p2,
    input [7:0] p3,p4,p5,
    input [7:0] p6,p7,p8,
    output reg [7:0] edge_out
);

reg signed [10:0] gx, gy;
reg [10:0] mag;

always @(posedge clk) begin
    if(rst) begin
        edge_out <= 0;
    end
    else begin
        // Explicit sign extension to 11 bits
        gx = -$signed({1'b0,p0}) + $signed({1'b0,p2})
             - ($signed({1'b0,p3}) <<< 1) + ($signed({1'b0,p5}) <<< 1)
             - $signed({1'b0,p6}) + $signed({1'b0,p8});

        gy =  $signed({1'b0,p0}) + ($signed({1'b0,p1}) <<< 1) + $signed({1'b0,p2})
             - $signed({1'b0,p6}) - ($signed({1'b0,p7}) <<< 1) - $signed({1'b0,p8});

        mag = (gx < 0 ? -gx : gx) + (gy < 0 ? -gy : gy);

        if(mag > 255)
            edge_out <= 8'hFF;
        else
            edge_out <= mag[7:0];
    end
end

endmodule