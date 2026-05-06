module uart_tx(
    input clk,
    output reg tx = 1'b1
);

parameter CLK_FREQ = 27000000;
parameter BAUD = 115200;
parameter CLKS_PER_BIT = CLK_FREQ / BAUD;

reg [15:0] clk_cnt = 0;
reg [3:0] bit_index = 0;
reg [9:0] frame;
reg sending = 0;

always @(posedge clk) begin

    if (!sending) begin
        // Frame = {STOP, DATA[7:0], START}
        frame <= {1'b1, 8'h41, 1'b0};
        sending <= 1;
        bit_index <= 0;
        clk_cnt <= 0;
    end
    else begin
        if (clk_cnt < CLKS_PER_BIT-1)
            clk_cnt <= clk_cnt + 1;
        else begin
            clk_cnt <= 0;
            tx <= frame[bit_index];
            bit_index <= bit_index + 1;

            if (bit_index == 9) begin
                sending <= 0;
                tx <= 1'b1;
            end
        end
    end

end

endmodule