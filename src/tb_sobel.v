`timescale 1ns/1ps

module tb_sobel;

reg clk;
reg rst;
reg [7:0] pixel_in;
wire [7:0] edge_out;

integer i;
integer outfile;

reg [7:0] image_mem [0:65535];

top uut(
    .clk(clk),
    .rst(rst),
    .pixel_in(pixel_in),
    .edge_out(edge_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    pixel_in = 0;

    $readmemh("input.hex", image_mem);
    outfile = $fopen("output.hex","w");

    #20 rst = 0;

    for(i=0;i<65536;i=i+1) begin
        pixel_in = image_mem[i];
        #10;
        $fwrite(outfile,"%02x\n", edge_out);
    end

    $fclose(outfile);
    $finish;
end

endmodule
