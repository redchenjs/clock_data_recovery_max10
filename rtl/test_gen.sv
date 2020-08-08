/*
 * test_gen.sv
 *
 *  Created on: 2020-08-08 20:45
 *      Author: Jack Chen <redchenjs@live.com>
 */

module test_gen #(
    parameter N = 8
) (
    input logic clk_i,
    input logic rst_n_i,

    input logic test_clk_i,

    output logic test_gen_o
);

logic test_clk;

edge_detect test_clk_edge(
   .clk_i(clk_i),
   .rst_n_i(rst_n_i),
   .data_i(test_clk_i),
   .pos_edge_o(test_clk)
);

lfsr #(.N(N)) lfsr(
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),
    .clk_en_i(test_clk),
    .data_o(test_gen_o)
);

endmodule
