LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

Entity koko_micro IS
	PORT(           clk     : IN std_logic;
		 	clk_mem : IN std_logic;
			clk_reg_file : IN std_logic;
			reset 	: IN std_logic;
			int_r   : IN std_logic;
			in_port : IN std_logic_vector(15 DOWNTO 0);
			out_port: OUT std_logic_vector(15 DOWNTO 0));
END koko_micro;

ARCHITECTURE a_koko_micro OF koko_micro IS

-----------------------------------------------------------------------------------
-------------------------------Components------------------------------------------
-----------------------------------------------------------------------------------

COMPONENT stage_reg IS
	GENERIC (n : integer := 16);
	PORT( Clk,Rst : IN std_logic;
		  WE : IN std_logic;
		  d : IN  std_logic_vector(n-1 DOWNTO 0);
		  q : OUT std_logic_vector(n-1 DOWNTO 0));
END COMPONENT;

Component data_ram IS
	PORT(
		clk : IN std_logic;
		en  : IN std_logic;
		wr  : IN std_logic;
		address : IN  std_logic_vector(15 DOWNTO 0);
		datain  : IN  std_logic_vector(15 DOWNTO 0);
		dataout : OUT std_logic_vector(15 DOWNTO 0));
END Component;

Component tri IS
	PORT(
		  en: IN std_logic;
		  input: IN std_logic_vector(15 DOWNTO 0);
		  output: OUT std_logic_vector(15 DOWNTO 0));
END Component;

Component mux_2x1_16 IS
	PORT(	
		sel : IN std_logic;
            	x1,x2  : IN std_logic_vector(15 downto 0);
		q : OUT std_logic_vector(15 DOWNTO 0));
END Component;

Component mux_4x1_16 IS
	PORT(	
		sel : IN std_logic_vector(1 downto 0);
            	x0,x1,x2,x3  : IN std_logic_vector(15 downto 0);
		q : OUT std_logic_vector(15 downto 0));
END Component;

Component mux_8x1_16 IS
	PORT(	sel : IN std_logic_vector(2 downto 0);
            x0,x1,x2,x3,x4,x5,x6,x7  : IN std_logic_vector(15 downto 0);
		    q : OUT std_logic_vector(15 downto 0));
END Component;

Component pc_selector IS
	PORT(	inc_pc, alu_pc, mem_pc : IN std_logic_vector(15 DOWNTO 0);
		alu_br_taken, mem_br_taken, intR, IF_int : IN std_logic;
		output : OUT std_logic_vector(15 DOWNTO 0));
END Component;

Component pc_inc is
    Port ( pc_in  : in  STD_LOGIC_VECTOR (15 downto 0);  
           pc_out  : out STD_LOGIC_VECTOR (15 downto 0));
end Component;
Component instruction_mem IS
	PORT(
		address : IN  std_logic_vector(15 DOWNTO 0);
		dataout : OUT std_logic_vector(31 DOWNTO 0));
END Component instruction_mem;


-----------------------------------------------------------------------------------
-------------------------------END-Components--------------------------------------
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
-------------------------------SIGNALS---------------------------------------------
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
------------------------------------------------------------------Mem Stage signals

SIGNAL ex_mem_reg_out : std_logic_vector(86 DOWNTO 0);
SIGNAL mem_wb_reg_reset : std_logic;

-- ram signals
SIGNAL mem_ram_en : std_logic;
SIGNAL mem_ram_wr : std_logic;
SIGNAL ram_address : std_logic_vector(15 DOWNTO 0);
SIGNAL ram_data_out: std_logic_vector(15 DOWNTO 0);

SIGNAL mem_zero_vec: std_logic_vector(15 DOWNTO 0);

SIGNAL mem_new_pc : std_logic_vector(15 DOWNTO 0);
SIGNAL mem_br_taken : std_logic;

-----------------------------------------------------------------------------------
-----------------------------------------------------------Write back Stage signals
SIGNAL mem_wb_reg_in : std_logic_vector(82 DOWNTO 0);
SIGNAL mem_wb_reg_out : std_logic_vector(82 DOWNTO 0);

SIGNAL wb_wr_en : std_logic;
SIGNAL wb_data : std_logic_vector(15 DOWNTO 0);
SIGNAL wb_r_add: std_logic_vector(2 DOWNTO 0);

-- in and out buffers
SIGNAL in_port_en : std_logic;
SIGNAL out_port_en : std_logic;
SIGNAL in_port_buf_out : std_logic_vector(15 DOWNTO 0);
-----------------------------------------------------------------------------------
-------------------------------END-SIGNALS-----------------------------------------
-----------------------------------------------------------------------------------
	
-----------------------------------------------------------------------------------
-------------------------------Connections-----------------------------------------
-----------------------------------------------------------------------------------
Begin

-----------------------------------------------------------------------------------
--stage_ex_mem_reg	: stage_reg generic map (87) port map (Clk, , '1', ,ex_mem_reg_out);
-----------------------------------------------------------------------------------
--------------------------------------------------------------Mem stage Connections
mux_ram_address      : mux_4x1_16 port map(ex_mem_reg_out(78 DOWNTO 77),mem_zero_vec,ex_mem_reg_out(15 DOWNTO 0),ex_mem_reg_out(47 DOWNTO 32),ex_mem_reg_out(74 DOWNTO 59),ram_address);
mem_data_ram         : data_ram port map(clk_mem,mem_ram_en,ex_mem_reg_out(76),ram_address,ex_mem_reg_out(31 DOWNTO 16),ram_data_out);
mem_new_pc_tri       : tri port map(mem_br_taken,ram_data_out,mem_new_pc);

mem_br_taken <= '1' when ex_mem_reg_out(58 DOWNTO 54) = "11001" or ex_mem_reg_out(58 DOWNTO 54) = "11010"
	   else '0';
mem_wb_reg_reset <= '1' when mem_wb_reg_out(82) = '1'
		else reset;
mem_ram_en <= '0' when mem_wb_reg_out(82) = '1'
		else '1' when ex_mem_reg_out(76) = '0'
		else ex_mem_reg_out(75);

mem_wb_reg_in <= mem_br_taken & ex_mem_reg_out(85 DOWNTO 79) & ram_data_out & ex_mem_reg_out(74 DOWNTO 48) & ex_mem_reg_out(47 DOWNTO 32) & ex_mem_reg_out(15 DOWNTO 0);
-----------------------------------------------------------------------------------
stage_mem_wb_reg     : stage_reg generic map (83) port map (Clk, mem_wb_reg_reset, '1', mem_wb_reg_in , mem_wb_reg_out);
-----------------------------------------------------------------------------------
-------------------------------------------------------Write back stage connections
mux_wb               : mux_8x1_16 port map(mem_wb_reg_out(78 DOWNTO 76),mem_zero_vec,mem_wb_reg_out(74 DOWNTO 59),mem_wb_reg_out(58 DOWNTO 43),mem_wb_reg_out(15 DOWNTO 0),mem_wb_reg_out(31 DOWNTO 16),in_port_buf_out,mem_zero_vec,mem_zero_vec,wb_data);
wb_in_port_tri 	     : tri port map(mem_wb_reg_out(80),in_port,in_port_buf_out);
wb_out_port_tri      : tri port map(mem_wb_reg_out(81),wb_data,out_port);
mem_zero_vec <= "0000000000000000";
wb_wr_en <= mem_wb_reg_out(75);
wb_r_add <=  mem_wb_reg_out(37 DOWNTO 35) when mem_wb_reg_out(79) = '0'
	else mem_wb_reg_out(34 DOWNTO 32) when mem_wb_reg_out(79) = '1'
	else "000";


END a_koko_micro;