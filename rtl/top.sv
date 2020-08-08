/*
 * top.sv
 *
 *  Created on: 2020-07-09 22:24
 *      Author: Jack Chen <redchenjs@live.com>
 */

module clock_data_recovery(
    input logic clk_i,          // clk_i = 12 MHz
    input logic rst_n_i,        // rst_n_i, active low

     input logic data_i,        // input data
    output logic clk_gen_o,     // recovered bit clock

     input logic test_clk_i,    // test clock in
    output logic test_gen_o     // test random data
);

logic sys_clk;
logic sys_rst_n;

sys_ctrl sys_ctrl(
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),

    .sys_clk_o(sys_clk),
    .sys_rst_n_o(sys_rst_n)
);

clk_gen #(.W(32), .R(8)) clk_gen(
    .clk_i(sys_clk),
    .rst_n_i(sys_rst_n),

    .data_i(data_i),

    .clk_gen_o(clk_gen_o)
);

test_gen #(.N(8)) test_gen(
    .clk_i(sys_clk),
    .rst_n_i(sys_rst_n),

    .test_clk_i(test_clk_i),

    .test_gen_o(test_gen_o)
);

endmodule
