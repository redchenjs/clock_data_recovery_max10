/*
 * data_delay.sv
 *
 *  Created on: 2020-08-09 13:58
 *      Author: Jack Chen <redchenjs@live.com>
 */

module data_delay #(
    parameter N = 1
) (
    input logic clk_i,
    input logic rst_n_i,

    input logic data_i,

    output logic data_o
);

logic data_d[N];

assign data_o = data_d[N-1];

always_ff @(posedge clk_i or negedge rst_n_i)
begin
    if (!rst_n_i) begin
        for (integer i=0; i<N; i++) begin
            data_d[i] <= 1'b0;
        end
    end else begin
        for (integer i=1; i<N; i++) begin
            data_d[i] <= data_d[i-1];
        end

        data_d[0] <= data_i;
    end
end

endmodule
