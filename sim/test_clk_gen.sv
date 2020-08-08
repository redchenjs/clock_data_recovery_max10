/*
 * test_clk_gen.sv
 *
 *  Created on: 2020-08-07 19:18
 *      Author: Jack Chen <redchenjs@live.com>
 */

`timescale 1ns / 1ps

module test_clk_gen;

logic clk_i;
logic rst_n_i;

logic [7:0] div_val;
logic       clk_div;
logic [7:0] clk_cnt;

logic data_o;

logic clk_gen_o;

wire clk_h = (clk_cnt < div_val[7:1]);
wire cnt_h = (clk_cnt < (div_val - 1'b1));

always_ff @(posedge clk_i or negedge rst_n_i)
begin
    if (!rst_n_i) begin
        clk_div <= 1'b0;

        clk_cnt <= 8'h00;
    end else begin
        clk_div <= clk_h;

        clk_cnt <= cnt_h ? clk_cnt + 1'b1 : 8'h00;
    end
end

lfsr #(.N(8)) lfsr (
    .clk_i(clk_div),
    .rst_n_i(rst_n_i),

    .clk_en_i(1'b1),

    .data_o(data_o)
);

clk_gen #(.W(32), .R(8)) clk_gen (
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),

    .data_i(data_o),

    .clk_gen_o(clk_gen_o)
);

initial begin
    clk_i   <= 1'b1;
    rst_n_i <= 1'b0;

    div_val <= 8'hf0;

    #2 rst_n_i <= 1'b1;
end

always begin
    #2.5 clk_i <= ~clk_i;
end

always begin
    #512000 div_val <= 8'hf1;
    #512000 div_val <= 8'hf2;
    #512000 div_val <= 8'hf0;
    #512000 div_val <= 8'hff;

    #512000 rst_n_i <= 1'b0;

    #25 $stop;
end

endmodule
