vsim work.koko_micro
# vsim work.koko_micro 
# Start time: 19:22:41 on Apr 08,2017
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.koko_micro(a_koko_micro)
# Loading work.reg(a_reg)
# ** Warning: (vsim-3473) Component instance "instruction_mem_port : instruction_mem" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /koko_micro File: /home/mg/Desktop/x/Koko-i8/kokocpu.vhd
# ** Warning: (vsim-3473) Component instance "pc_inc_port : pc_inc" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /koko_micro File: /home/mg/Desktop/x/Koko-i8/kokocpu.vhd
# ** Warning: (vsim-3473) Component instance "pc_selector_port : pc_selector" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /koko_micro File: /home/mg/Desktop/x/Koko-i8/kokocpu.vhd
# Loading work.stage_reg(a_stage_reg)
# ** Warning: (vsim-3473) Component instance "stall_detector_port : stall_detector" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /koko_micro File: /home/mg/Desktop/x/Koko-i8/kokocpu.vhd
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.regfile(a_regfile)
# Loading work.dec_3_x_8(a_dec_3_x_8)
# ** Warning: (vsim-3473) Component instance "control_unit_port : control_unit" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /koko_micro File: /home/mg/Desktop/x/Koko-i8/kokocpu.vhd
# Loading work.source_selector(a_source_selector)
# Loading work.forwarding_unit(a_forwarding_unit)
# Loading work.mux_2x1_16(a_mux_2x1_16)
# Loading work.mux_4x1_16(a_mux_4x1_16)
# Loading ieee.numeric_std(body)
# Loading work.alu(struct)
# Loading work.generic_nadder(a_my_nadder)
# Loading work.full_adder(my_adder)
# Loading work.data_ram(a_data_ram)
# Loading work.mux_8x1_16(a_mux_8x1_16)
# Loading work.tri(a_tri)
add wave -position insertpoint  \
sim:/koko_micro/clk \
sim:/koko_micro/clk_mem \
sim:/koko_micro/clk_reg_file \
sim:/koko_micro/reset \
sim:/koko_micro/int_r \
sim:/koko_micro/in_port \
sim:/koko_micro/out_port \
sim:/koko_micro/pc_input \
sim:/koko_micro/pc_output \
sim:/koko_micro/pc_incremented \
sim:/koko_micro/ir \
sim:/koko_micro/stall_sig \
sim:/koko_micro/pc_en \
sim:/koko_micro/IF_ID_reg_out \
sim:/koko_micro/IF_ID_reg_in \
sim:/koko_micro/rs_data \
sim:/koko_micro/rt_data \
sim:/koko_micro/rd_data \
sim:/koko_micro/pc_signal \
sim:/koko_micro/ea_imm_signal \
sim:/koko_micro/r0 \
sim:/koko_micro/r1 \
sim:/koko_micro/r2 \
sim:/koko_micro/r3 \
sim:/koko_micro/r4 \
sim:/koko_micro/r5 \
sim:/koko_micro/r6 \
sim:/koko_micro/read_en \
sim:/koko_micro/rs_selected \
sim:/koko_micro/rt \
sim:/koko_micro/rd \
sim:/koko_micro/br_taken \
sim:/koko_micro/sp_select \
sim:/koko_micro/out_en_signal \
sim:/koko_micro/in_en_signal \
sim:/koko_micro/ld_signal \
sim:/koko_micro/alu_signals \
sim:/koko_micro/op_signal \
sim:/koko_micro/wb_signals \
sim:/koko_micro/ram_signals \
sim:/koko_micro/id_ex_reg_out \
sim:/koko_micro/id_ex_reg_in \
sim:/koko_micro/alu_br_taken \
sim:/koko_micro/selector_output \
sim:/koko_micro/rst_basedon_taken \
sim:/koko_micro/br_opcode \
sim:/koko_micro/ex_mem_reg_reset \
sim:/koko_micro/rs_rd \
sim:/koko_micro/alu_new_pc \
sim:/koko_micro/rt_imm \
sim:/koko_micro/alu_ex_out \
sim:/koko_micro/mux_a \
sim:/koko_micro/mux_b \
sim:/koko_micro/a \
sim:/koko_micro/b \
sim:/koko_micro/flags_in \
sim:/koko_micro/flags_out \
sim:/koko_micro/flags_old_out \
sim:/koko_micro/to_flags \
sim:/koko_micro/ex_mem_reg_in \
sim:/koko_micro/forwarded_e_to_e \
sim:/koko_micro/forwarded_m_to_e \
sim:/koko_micro/ex_mem_reg_out \
sim:/koko_micro/mem_wb_reg_reset \
sim:/koko_micro/mem_ram_en \
sim:/koko_micro/mux_mem_s \
sim:/koko_micro/ram_address \
sim:/koko_micro/ram_data_out \
sim:/koko_micro/ram_data_in \
sim:/koko_micro/mem_zero_vec \
sim:/koko_micro/mem_new_pc \
sim:/koko_micro/mem_br_taken_en_reg \
sim:/koko_micro/mem_br_taken \
sim:/koko_micro/mem_wb_reg_in \
sim:/koko_micro/mem_wb_reg_out \
sim:/koko_micro/wb_en \
sim:/koko_micro/wb_data \
sim:/koko_micro/wb_add \
sim:/koko_micro/in_port_en \
sim:/koko_micro/out_port_en \
sim:/koko_micro/in_port_buf_out
mem load -i /media/psf/Home/Koko-i8/test_ins.mem /koko_micro/instruction_mem_port/instruction_mem
mem load -i /media/psf/Home/Koko-i8/test_ram.mem /koko_micro/mem_data_ram/ram
force -freeze sim:/koko_micro/reset 1 0
force -freeze sim:/koko_micro/int_r 0 0
force -freeze sim:/koko_micro/in_port 16'h0000 0
force -freeze sim:/koko_micro/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/koko_micro/clk_mem 1 0, 0 {50 ps} -r 100
force -freeze sim:/koko_micro/clk_reg_file 1 0, 0 {25 ps} -r 50
run
force -freeze sim:/koko_micro/reset 0 0
