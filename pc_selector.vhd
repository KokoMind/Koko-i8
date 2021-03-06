LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY pc_selector IS
	PORT(	int_addr, inc_pc, alu_pc, mem_pc : IN std_logic_vector(15 DOWNTO 0);
		alu_br_taken, mem_br_taken, intR, IF_int, rst : IN std_logic;
		output : OUT std_logic_vector(15 DOWNTO 0));
END pc_selector;

ARCHITECTURE a_pc_selector OF pc_selector IS
	BEGIN

		output <= int_addr when intR = '1' or IF_int = '1'
		else "0000000000000000" when rst = '1'
		else mem_pc when mem_br_taken = '1'
		else alu_pc when alu_br_taken = '1'
		else inc_pc;

END a_pc_selector;

