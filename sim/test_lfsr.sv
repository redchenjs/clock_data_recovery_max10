/*
 * test_lfsr.sv
 *
 *  Created on: 2020-07-09 22:59
 *      Author: Jack Chen <redchenjs@live.com>
 */

`timescale 1ns / 1ps

module test_lfsr;

parameter N = 4;

logic clk_i;
logic rst_n_i;

logic [N-1:0] data_o;

lfsr #(N) test_lfsr (
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),

    .data_o(data_o)
);

initial begin
    clk_i   <= 1'b1;
    rst_n_i <= 1'b0;

    #2 rst_n_i <= 1'b1;
end

always begin
    #2.5 clk_i <= ~clk_i;
end

always begin
    #5120 rst_n_i <= 1'b0;

    #25 $stop;
end

endmodule
