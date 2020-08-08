/*
 * lfsr.sv
 *
 *  Created on: 2020-07-09 22:33
 *      Author: Jack Chen <redchenjs@live.com>
 */

module lfsr #(
    parameter N = 8
) (
    input logic clk_i,
    input logic rst_n_i,

    input logic clk_en_i,

    output logic [N-1:0] data_o
);

logic [N-1:0] data_lfsr;
logic         data_xnor;

assign data_o = data_lfsr;

// Reference: http://www.xilinx.com/support/documentation/application_notes/xapp052.pdf
always_comb begin
    case (N)
        3: begin
            data_xnor = data_lfsr[2] ^~ data_lfsr[1];
        end
        4: begin
            data_xnor = data_lfsr[3] ^~ data_lfsr[2];
        end
        5: begin
            data_xnor = data_lfsr[4] ^~ data_lfsr[2];
        end
        6: begin
            data_xnor = data_lfsr[5] ^~ data_lfsr[4];
        end
        7: begin
            data_xnor = data_lfsr[6] ^~ data_lfsr[5];
        end
        8: begin
            data_xnor = data_lfsr[7] ^~ data_lfsr[5] ^~ data_lfsr[4] ^~ data_lfsr[3];
        end
        9: begin
            data_xnor = data_lfsr[8] ^~ data_lfsr[4];
        end
        10: begin
            data_xnor = data_lfsr[9] ^~ data_lfsr[6];
        end
        11: begin
            data_xnor = data_lfsr[10] ^~ data_lfsr[8];
        end
        12: begin
            data_xnor = data_lfsr[11] ^~ data_lfsr[5] ^~ data_lfsr[3] ^~ data_lfsr[0];
        end
        13: begin
            data_xnor = data_lfsr[12] ^~ data_lfsr[3] ^~ data_lfsr[2] ^~ data_lfsr[0];
        end
        14: begin
            data_xnor = data_lfsr[13] ^~ data_lfsr[4] ^~ data_lfsr[2] ^~ data_lfsr[0];
        end
        15: begin
            data_xnor = data_lfsr[14] ^~ data_lfsr[13];
        end
        16: begin
            data_xnor = data_lfsr[15] ^~ data_lfsr[14] ^~ data_lfsr[12] ^~ data_lfsr[3];
        end
        17: begin
            data_xnor = data_lfsr[16] ^~ data_lfsr[13];
        end
        18: begin
            data_xnor = data_lfsr[17] ^~ data_lfsr[10];
        end
        19: begin
            data_xnor = data_lfsr[18] ^~ data_lfsr[5] ^~ data_lfsr[1] ^~ data_lfsr[0];
        end
        20: begin
            data_xnor = data_lfsr[19] ^~ data_lfsr[16];
        end
        21: begin
            data_xnor = data_lfsr[20] ^~ data_lfsr[18];
        end
        22: begin
            data_xnor = data_lfsr[21] ^~ data_lfsr[20];
        end
        23: begin
            data_xnor = data_lfsr[22] ^~ data_lfsr[17];
        end
        24: begin
            data_xnor = data_lfsr[23] ^~ data_lfsr[22] ^~ data_lfsr[21] ^~ data_lfsr[16];
        end
        25: begin
            data_xnor = data_lfsr[24] ^~ data_lfsr[21];
        end
        26: begin
            data_xnor = data_lfsr[25] ^~ data_lfsr[5] ^~ data_lfsr[1] ^~ data_lfsr[0];
        end
        27: begin
            data_xnor = data_lfsr[26] ^~ data_lfsr[4] ^~ data_lfsr[1] ^~ data_lfsr[0];
        end
        28: begin
            data_xnor = data_lfsr[27] ^~ data_lfsr[24];
        end
        29: begin
            data_xnor = data_lfsr[28] ^~ data_lfsr[26];
        end
        30: begin
            data_xnor = data_lfsr[29] ^~ data_lfsr[5] ^~ data_lfsr[3] ^~ data_lfsr[0];
        end
        31: begin
            data_xnor = data_lfsr[30] ^~ data_lfsr[27];
        end
        32: begin
            data_xnor = data_lfsr[31] ^~ data_lfsr[21] ^~ data_lfsr[1] ^~ data_lfsr[0];
        end
    endcase
end

always_ff @(posedge clk_i or negedge rst_n_i)
begin
    if (!rst_n_i) begin
        data_lfsr <= {N{1'b0}};
    end else begin
        if (clk_en_i) begin
            data_lfsr <= {data_lfsr[N-2:0], data_xnor};
        end
    end
end

endmodule
