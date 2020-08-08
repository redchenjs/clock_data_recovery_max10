derive_clock_uncertainty
derive_pll_clocks -create_base_clocks

set_false_path -from [get_ports {rst_n_i}]

set_false_path -from [get_ports {data_i}]
set_false_path -to [get_ports {clk_gen_o}]

set_false_path -from [get_ports {test_clk_i}]
set_false_path -to [get_ports {test_gen_o}]
