----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:08:35 11/23/2015 
-- Design Name: 
-- Module Name:    CPU_manager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use C_SIGNAL.TEST_SIGNAL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU_manager is
	port (
	clk1: IN std_logic;
	rst: IN std_logic;
	--instruction: IN std_logic_vector(15 downto 0);
	Ram1Data: inout std_logic_vector(15 downto 0);
	ToRam1_addr: out std_logic_vector(17 downto 0);
	Ram1EN: out std_logic;
	Ram1OE: out std_logic;
	Ram1WE: out std_logic;
	
	rdn: out std_logic;
	wrn: out std_logic;
	data_ready: in std_logic;
	tbre: in std_logic;
	tsre: in std_logic;
	
	Ram2Data: inout std_logic_vector(15 downto 0);
	ToRam2_addr: out std_logic_vector(17 downto 0);
	Ram2EN: out std_logic;
	Ram2OE: out std_logic;
	Ram2WE: out std_logic;
	--instruction_out: out std_logic_vector(15 downto 0);
	DIGITAL_H: out std_logic_vector(6 downto 0);
	DIGITAL_L: out std_logic_vector(6 downto 0)
	);
end CPU_manager;

architecture Behavioral of CPU_manager is	
	COMPONENT PC
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		from_mux_pc : IN std_logic_vector(15 downto 0);
		from_riskCheck : IN std_logic;          
		pc_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	COMPONENT IF_manager
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		old_pc : IN std_logic_vector(15 downto 0);
		write_enable : IN std_logic;
		write_Data : IN std_logic_vector(15 downto 0);
		target_Addr : IN std_logic_vector(15 downto 0);
		RAddr : IN std_logic_vector(15 downto 0);    
		Ram2Data : INOUT std_logic_vector(15 downto 0);      
		new_pc : OUT std_logic_vector(15 downto 0);
		Instruction : OUT std_logic_vector(15 downto 0);
		ToRam2_addr : OUT std_logic_vector(15 downto 0);
		Ram2EN : OUT std_logic;
		Ram2OE : OUT std_logic;
		Ram2WE : OUT std_logic
		);
	END COMPONENT;

	COMPONENT IF_ID
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		from_riskCheck : IN std_logic;
		updated_pc_in : IN std_logic_vector(15 downto 0);
		instruction_in : IN std_logic_vector(15 downto 0);          
		updated_pc_out : OUT std_logic_vector(15 downto 0);
		instruction_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT ID_EX
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		control_branchOrJump_in : IN std_logic_vector(2 downto 0);
		control_desRegister_in : IN std_logic_vector(1 downto 0);
		control_ALUsrc1_in : IN std_logic_vector(2 downto 0);
		control_ALUsrc2_in : IN std_logic_vector(2 downto 0);
		control_ALUop_in : IN std_logic_vector(3 downto 0);
		control_memToReg_in : IN std_logic;
		control_regWrite_in : IN std_logic_vector(2 downto 0);
		control_memWrite_in : IN std_logic;
		control_memRead_in : IN std_logic;
		control_WE_in : IN std_logic;
		control_TE_in : IN std_logic;
		updated_pc_in : IN std_logic_vector(15 downto 0);
		from_register1_in : IN std_logic_vector(15 downto 0);
		from_register2_in : IN std_logic_vector(15 downto 0);
		from_IH_in : IN std_logic_vector(15 downto 0);
		from_SP_in : IN std_logic_vector(15 downto 0);
		from_imm_exp_in : IN std_logic_vector(15 downto 0);
		from_T_in : IN std_logic_vector(15 downto 0);
		from_instruction_7_5_in : IN std_logic_vector(2 downto 0);
		from_instruction_4_2_in : IN std_logic_vector(2 downto 0);
		from_instruction_10_8_in : IN std_logic_vector(2 downto 0);          
		control_branchOrJump_out : OUT std_logic_vector(2 downto 0);
		control_desRegister_out : OUT std_logic_vector(1 downto 0);
		control_ALUsrc1_out : OUT std_logic_vector(2 downto 0);
		control_ALUsrc2_out : OUT std_logic_vector(2 downto 0);
		control_ALUop_out : OUT std_logic_vector(3 downto 0);
		control_memToReg_out : OUT std_logic;
		control_regWrite_out : OUT std_logic_vector(2 downto 0);
		control_memWrite_out : OUT std_logic;
		control_memRead_out : OUT std_logic;
		control_WE_out : OUT std_logic;
		control_TE_out : OUT std_logic;
		updated_pc_out : OUT std_logic_vector(15 downto 0);
		from_register1_out : OUT std_logic_vector(15 downto 0);
		from_register2_out : OUT std_logic_vector(15 downto 0);
		from_IH_out : OUT std_logic_vector(15 downto 0);
		from_SP_out : OUT std_logic_vector(15 downto 0);
		from_imm_exp_out : OUT std_logic_vector(15 downto 0);
		from_T_out : OUT std_logic_vector(15 downto 0);
		from_instruction_7_5_out : OUT std_logic_vector(2 downto 0);
		from_instruction_4_2_out : OUT std_logic_vector(2 downto 0);
		from_instruction_10_8_out : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	COMPONENT ID_manager
	PORT(
		clk: IN std_logic;
		rst: IN std_logic;
		instruction : IN std_logic_vector(15 downto 0);
		from_PC : IN std_logic_vector(15 downto 0);
		write_addr : IN std_logic_vector(2 downto 0);
		write_data : IN std_logic_vector(15 downto 0);
		regWrite : IN std_logic_vector(2 downto 0);
		from_branch_control : IN std_logic;
		from_risk_check : IN std_logic;          
		out_branchOrJump : OUT std_logic_vector(2 downto 0);
		out_desRegister : OUT std_logic_vector(1 downto 0);
		out_ALUsrc1 : OUT std_logic_vector(2 downto 0);
		out_ALUsrc2 : OUT std_logic_vector(2 downto 0);
		out_ALUop : OUT std_logic_vector(3 downto 0);
		out_memToReg : OUT std_logic;
		out_regWrite : OUT std_logic_vector(2 downto 0);
		out_memWrite : OUT std_logic;
		out_memRead : OUT std_logic;
		out_WC : OUT std_logic;
		out_T_Enable : OUT std_logic;
		PC_result : OUT std_logic_vector(15 downto 0);
		register_result1 : OUT std_logic_vector(15 downto 0);
		register_result2 : OUT std_logic_vector(15 downto 0);
		imm_exp_result : OUT std_logic_vector(15 downto 0);
		IH_result : OUT std_logic_vector(15 downto 0);
		SP_result : OUT std_logic_vector(15 downto 0);
		T_result : OUT std_logic_vector(15 downto 0);
		instruction_7_5 : OUT std_logic_vector(2 downto 0);
		instruction_4_2 : OUT std_logic_vector(2 downto 0);
		instruction_10_8 : OUT std_logic_vector(2 downto 0);
		out_register1: OUT std_logic_vector(15 downto 0);--debug
		out_register2: OUT std_logic_vector(15 downto 0)--debug
		);
	END COMPONENT;

	--signal tmp1: std_logic_vector(15 downto 0);
	--signal tmp2: std_logic_vector(15 downto 0);
	COMPONENT EX_manager
	PORT(
		--op1: out std_logic_vector(15 downto 0);	
		--op2: out std_logic_vector(15 downto 0);
		--control_branchOrJump : IN std_logic_vector(2 downto 0);
		control_desRegister : IN std_logic_vector(1 downto 0);
		control_ALUsrc1 : IN std_logic_vector(2 downto 0);
		control_ALUsrc2 : IN std_logic_vector(2 downto 0);
		control_ALUop : IN std_logic_vector(3 downto 0);
		control_memToReg : IN std_logic;
		control_regWrite : IN std_logic_vector(2 downto 0);
		control_memWrite : IN std_logic;
		control_memRead : IN std_logic;
		control_WC : IN std_logic;
		--control_TE : IN std_logic;
		from_pc : IN std_logic_vector(15 downto 0);
		register_read_result1 : IN std_logic_vector(15 downto 0);
		register_read_result2 : IN std_logic_vector(15 downto 0);
		from_HI : IN std_logic_vector(15 downto 0);
		from_SP : IN std_logic_vector(15 downto 0);
		from_imm_exp : IN std_logic_vector(15 downto 0);
		from_instruction_7_5 : IN std_logic_vector(2 downto 0);
		from_instruction_4_2 : IN std_logic_vector(2 downto 0);
		from_instruction_10_8 : IN std_logic_vector(2 downto 0);
		Fsrc1 : IN std_logic_vector(1 downto 0);
		Fsrc2 : IN std_logic_vector(1 downto 0);
		FmemData: IN std_logic_vector(1 downto 0);
		result_from_ME_WB : IN std_logic_vector(15 downto 0);
		result_from_EX_ME : IN std_logic_vector(15 downto 0);          
		out_memToReg : OUT std_logic;
		out_regWrite : OUT std_logic_vector(2 downto 0);
		out_memWrite : OUT std_logic;
		out_memRead : OUT std_logic;
		out_ALUresult : OUT std_logic_vector(15 downto 0);
		out_mux_writeRamData : OUT std_logic_vector(15 downto 0);
		out_mux_target_register : OUT std_logic_vector(2 downto 0);
		out_sum : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT riskCheck
	PORT(
		MemRead : IN std_logic;
		Rtarget : IN std_logic_vector(2 downto 0);
		Instructor : IN std_logic_vector(15 downto 0);          
		Nop : OUT std_logic;
		waitEnable : OUT std_logic
		);
	END COMPONENT;

	COMPONENT byPass
	PORT(
		ALUsrc1 : IN std_logic_vector(2 downto 0);
		ALUsrc2 : IN std_logic_vector(2 downto 0);
		ME_ReqWrite : IN std_logic_vector(2 downto 0);
		WB_ReqWrite : IN std_logic_vector(2 downto 0);
		T_Enable : IN std_logic;
		rx_addr : IN std_logic_vector(2 downto 0);
		ry_addr : IN std_logic_vector(2 downto 0);
		ME_target : IN std_logic_vector(2 downto 0);
		WB_target : IN std_logic_vector(2 downto 0);          
		Fsrc1 : OUT std_logic_vector(1 downto 0);
		Fsrc2 : OUT std_logic_vector(1 downto 0);
		Fbranch : OUT std_logic_vector(1 downto 0);	
		Control_WC: IN std_logic;
		FmemData: OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

	COMPONENT branchControl
	PORT(
		rx : IN std_logic_vector(15 downto 0);
		T : IN std_logic_vector(15 downto 0);
		ME_Value : IN std_logic_vector(15 downto 0);
		WB_Value : IN std_logic_vector(15 downto 0);
		BranchOrJump : IN std_logic_vector(2 downto 0);
		Fbranch : IN std_logic_vector(1 downto 0);          
		PC_Choose : OUT std_logic;
		kill : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT mux_PC
	PORT(
		new_PC : IN std_logic_vector(15 downto 0);
		branch_PC : IN std_logic_vector(15 downto 0);
		PC_Choose : IN std_logic;          
		next_PC : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	COMPONENT EX_ME
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		control_memToReg_in : IN std_logic;
		control_regWrite_in : IN std_logic_vector(2 downto 0);
		control_memRead_in : IN std_logic;
		control_memWrite_in : IN std_logic;
		from_branch_control_in : IN std_logic;
		store_data : IN std_logic_vector(15 downto 0);
		target_Addr : IN std_logic_vector(2 downto 0);
		ALUresult_in : IN std_logic_vector(15 downto 0);          
		control_memToReg_out : OUT std_logic;
		control_regWrite_out : OUT std_logic_vector(2 downto 0);
		control_memRead_out : OUT std_logic;
		control_memWrite_out : OUT std_logic;
		from_branch_control_out : OUT std_logic;
		store_data_out : OUT std_logic_vector(15 downto 0);
		target_Addr_out : OUT std_logic_vector(2 downto 0);
		ALUresult_out : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ME_manager
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		control_memToReg_in : IN std_logic;
		control_regWrite_in : IN std_logic_vector(2 downto 0);
		control_memWrite_in : IN std_logic;
		control_memRead_in : IN std_logic;
		ALUresult : IN std_logic_vector(15 downto 0);
		store_data : IN std_logic_vector(15 downto 0);
		data_ready : IN std_logic;
		tbre : IN std_logic;
		tsre : IN std_logic;    
		data : INOUT std_logic_vector(15 downto 0);      
		control_regWrite_out : OUT std_logic_vector(2 downto 0);
		result_out : OUT std_logic_vector(15 downto 0);
		Ram1EN : OUT std_logic;
		Ram1OE : OUT std_logic;
		Ram1WE : OUT std_logic;
		ToRam1_addr : OUT std_logic_vector(15 downto 0);
		wrn : OUT std_logic;
		rdn : OUT std_logic;

		Rtarget_in: in std_logic_vector(2 downto 0);
		Rtarget_out: out std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	COMPONENT ME_WB
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		regWrite_in : IN std_logic_vector(2 downto 0);
		data_result_in : IN std_logic_vector(15 downto 0);
		Rtarget_in : IN std_logic_vector(2 downto 0);          
		regWrite_out : OUT std_logic_vector(2 downto 0);
		data_result_out : OUT std_logic_vector(15 downto 0);
		Rtarget_out : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
	COMPONENT translator
	PORT (
		input_bits: in std_logic_vector(7 downto 0);
		H: out std_logic_vector(6 downto 0);
		L: out std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	signal clk: std_logic := '1';
	signal clk2: std_logic := '1';

	signal PC_PC: std_logic_vector(15 downto 0);
	
	signal IF_PC: std_logic_vector(15 downto 0);
	signal IF_instruction: std_logic_vector(15 downto 0);

	signal riskCheck_waitEnable: std_logic;
	signal riskCheck_Nop: std_logic;
	
	signal IF_ID_pc: std_logic_vector(15 downto 0);
	signal IF_ID_instruction: std_logic_vector(15 downto 0);

	signal ID_branchOrJump: std_logic_vector(2 downto 0);
	signal ID_disRegister: std_logic_vector(1 downto 0);
	signal ID_ALUsrc1: std_logic_vector(2 downto 0);
	signal ID_ALUsrc2: std_logic_vector(2 downto 0);
	signal ID_ALUop: std_logic_vector(3 downto 0);
	signal ID_memToReg: std_logic;
	signal ID_regWrite: std_logic_vector(2 downto 0);
	signal ID_memWrite: std_logic;
	signal ID_memRead: std_logic;
	signal ID_WC: std_logic;
	signal ID_T_Enable: std_logic;
	signal ID_register_result1: std_logic_vector(15 downto 0);
	signal ID_register_result2: std_logic_vector(15 downto 0);
	signal ID_PC: std_logic_vector(15 downto 0);
	signal ID_imm_exp_result: std_logic_vector(15 downto 0);
	signal ID_IH: std_logic_vector(15 downto 0);
	signal ID_SP: std_logic_vector(15 downto 0);
	signal ID_T: std_logic_vector(15 downto 0);
	signal ID_instruction_10_8: std_logic_vector(2 downto 0);
	signal ID_instruction_7_5: std_logic_vector(2 downto 0);
	signal ID_instruction_4_2: std_logic_vector(2 downto 0);

	signal ID_EX_branchOrJump: std_logic_vector(2 downto 0);
	signal ID_EX_disRegister: std_logic_vector(1 downto 0);
	signal ID_EX_ALUsrc1: std_logic_vector(2 downto 0);
	signal ID_EX_ALUsrc2: std_logic_vector(2 downto 0);
	signal ID_EX_ALUop: std_logic_vector(3 downto 0);
	signal ID_EX_memToReg: std_logic;
	signal ID_EX_regWrite: std_logic_vector(2 downto 0);
	signal ID_EX_memWrite: std_logic;
	signal ID_EX_memRead: std_logic;
	signal ID_EX_WC: std_logic;
	signal ID_EX_T_Enable: std_logic;
	signal ID_EX_PC: std_logic_vector(15 downto 0);
	signal ID_EX_register_result1: std_logic_vector(15 downto 0);
	signal ID_EX_register_result2: std_logic_vector(15 downto 0);
	signal ID_EX_IH: std_logic_vector(15 downto 0);
	signal ID_EX_SP: std_logic_vector(15 downto 0);
	signal ID_EX_imm_exp_result: std_logic_vector(15 downto 0);
	signal ID_EX_T: std_logic_vector(15 downto 0);
	signal ID_EX_instruction_7_5: std_logic_vector(2 downto 0);
	signal ID_EX_instruction_4_2: std_logic_vector(2 downto 0);
	signal ID_EX_instruction_10_8: std_logic_vector(2 downto 0);

	signal branchControl_PC_Choose: std_logic;
	signal branchControl_kill: std_logic;

	signal byPass_Fsrc1: std_logic_vector(1 downto 0);
	signal byPass_Fsrc2: std_logic_vector(1 downto 0);
	signal byPass_Fbranch: std_logic_vector(1 downto 0);
	signal byPass_FmemData: std_logic_vector(1 downto 0);

	signal EX_memToReg: std_logic;
	signal EX_regWrite: std_logic_vector(2 downto 0);
	signal EX_memWrite: std_logic;
	signal EX_memRead: std_logic;
	signal EX_Rtarget: std_logic_vector(2 downto 0);
	signal EX_ALUresult: std_logic_vector(15 downto 0);
	signal EX_sum: std_logic_vector(15 downto 0);
	signal EX_wrireData: std_logic_vector(15 downto 0);
	
	signal mux_PC_PC: std_logic_vector(15 downto 0);

	signal EX_ME_memtoReg: std_logic;
	signal EX_ME_regWrite: std_logic_vector(2 downto 0);
	signal EX_ME_memWrite: std_logic;
	signal EX_ME_memRead: std_logic;
	signal EX_ME_kill: std_logic;
	signal EX_ME_Result: std_logic_vector(15 downto 0);
	signal EX_ME_store_data: std_logic_vector(15 downto 0);
	signal EX_ME_Rtarget: std_logic_vector(2 downto 0);

	signal ME_Result: std_logic_vector(15 downto 0);
	signal ME_regWrite: std_logic_vector(2 downto 0);	
	signal ME_Rtarget: std_logic_vector(2 downto 0);

	signal ME_WB_Result: std_logic_vector(15 downto 0);
	signal ME_WB_regWrite: std_logic_vector(2 downto 0);
	signal ME_WB_Rtarget: std_logic_vector(2 downto 0);
	
	signal out_register1: std_logic_vector(15 downto 0);--debug
	signal out_register2: std_logic_vector(15 downto 0);--debug
	
begin
	ToRam1_addr(17 downto 16) <= "00";
	ToRam2_addr(17 downto 16) <= "00";
	--instruction_out <= IF_instruction;
	--instruction_out(15 downto 14) <= byPass_Fsrc1;--debug
	--instruction_out(13 downto 12) <= byPass_Fsrc2;--debug
	--instruction_out(11 downto 10) <= byPass_Fbranch;
	--instruction_out(9 downto 8) <= byPass_FmemData;
	--instruction_out <= EX_ALUresult;
--	instruction_out(15) <= ID_EX_T_Enable;
--	instruction_out(14 downto 12) <= EX_ME_regWrite;
--	instruction_out(5 downto 0) <= EX_ME_Result(5 downto 0);
--	instruction_out(9) <= branchControl_PC_Choose;
--	instruction_out(8 downto 6) <= ID_EX_branchOrJump;
--	instruction_out(11 downto 10) <= byPass_Fbranch;
	--instruction_out(15) <= s
	--instruction_out(15 downto 0) <= EX_ME_Result(15 downto 0);
	--instruction_out(3 downto 2) <= byPass_Fsrc1;
	--instruction_out(1 downto 0) <= byPass_Fsrc2;
	--instruction_out(15 downto 13) <= EX_ME_Rtarget;
	--instruction_out(12 downto 10) <= ID_EX_instruction_7_5;
	--instruction_out(9 downto 7) <= ID_EX_ALUsrc2;
	--instruction_out(6 downto 4) <= EX_ME_regWrite;
	--instruction_out(3 downto 0) <= (others => '1');
	--instruction_out(11 downto 8) <= (others => '0');
	--instruction_out(15 downto 8) <= tmp1(15 downto 8);
	--instruction_out(11 downto 0) <= tmp2(11 downto 0);
	--instruction_out(15 downto 12) <= ID_EX_ALUop;
	--instruction_out(7 downto 0) <= ID_EX_imm_exp_result(7 downto 0);
	--instruction_out(15 downto 0) <= IF_instruction;
	--instruction_out(15 downto 13) <= ID_EX_ALUsrc1;
	--instruction_out(12 downto 10) <= ID_EX_ALUsrc2;
	--instruction_out(9 downto 8) <= "00";
	--instruction_out(7 downto 0) <= ID_EX_imm_exp_result(7 downto 0);
	--instruction_out(9) <= branchControl_PC_Choose;
	--instruction_out(8) <= branchControl_kill;
	--instruction_out <= ID_imm_exp_result;

	process(clk1)
	begin
		if (falling_edge(clk1)) then
			clk2 <= not clk2;
		end if;
	end process;

	process(clk2) 
	begin
		if (falling_edge(clk2)) then
			clk <= not clk;
		end if;
	end process;
--	clk <= clk1;

	Inst_PC: PC PORT MAP(
		clk => clk,
		rst => rst,
		from_mux_pc => mux_PC_PC,
		from_riskCheck => riskCheck_waitEnable,
		pc_out => PC_PC
	);

	Inst_IF_manager: IF_manager PORT MAP(
		clk => clk,
		rst => rst,
		old_pc => PC_PC,
		new_pc => IF_PC,
		Instruction => IF_instruction,
		write_enable => '0',
		write_Data => (others => '0'),
		target_Addr => (others => '0'),
		RAddr => PC_PC,
		Ram2Data => Ram2Data,
		ToRam2_addr => ToRam2_addr(15 downto 0),
		Ram2EN => Ram2EN,
		Ram2OE => Ram2OE,
		Ram2WE => Ram2WE
	);

	Inst_IF_ID: IF_ID PORT MAP(
		clk => clk,
		rst => rst,
		from_riskCheck => riskCheck_waitEnable,
		updated_pc_in => IF_PC,
		instruction_in => IF_instruction,
		updated_pc_out => IF_ID_pc,
		instruction_out => IF_ID_instruction
	);

	Inst_ID_manager: ID_manager PORT MAP(
		clk => clk,
		rst => rst,
		instruction => IF_ID_instruction,
		from_PC => IF_ID_PC,
		write_addr => ME_WB_Rtarget,
		write_data => ME_WB_Result,
		regWrite => ME_WB_regWrite,
		from_branch_control => EX_ME_kill,
		from_risk_check => riskCheck_Nop,
		out_branchOrJump => ID_branchOrJump,
		out_desRegister => ID_disRegister,
		out_ALUsrc1 => ID_ALUsrc1,
		out_ALUsrc2 => ID_ALUsrc2,
		out_ALUop => ID_ALUop,
		out_memToReg => ID_memToReg,
		out_regWrite => ID_regWrite,
		out_memWrite => ID_memWrite,
		out_memRead => ID_memRead,
		out_WC => ID_WC,
		out_T_Enable => ID_T_Enable,
		PC_result => ID_PC,
		register_result1 => ID_register_result1,
		register_result2 => ID_register_result2,
		imm_exp_result => ID_imm_exp_result,
		IH_result => ID_IH,
		SP_result => ID_SP,
		T_result => ID_T,
		instruction_7_5 => ID_instruction_7_5,
		instruction_4_2 => ID_instruction_4_2,
		instruction_10_8 => ID_instruction_10_8,
		out_register1 => out_register1,--debug
		out_register2 => out_register2--debug
	);

	Inst_riskCheck: riskCheck PORT MAP(
		MemRead => ID_EX_memRead,
		Rtarget => EX_Rtarget,
		Instructor => IF_ID_instruction,
		Nop => riskCheck_Nop,
		waitEnable => riskCheck_waitEnable
	);

	Inst_ID_EX: ID_EX PORT MAP(
		clk => clk,
		rst => rst,
		control_branchOrJump_in => ID_branchOrJump,
		control_desRegister_in => ID_disRegister,
		control_ALUsrc1_in => ID_ALUsrc1,
		control_ALUsrc2_in => ID_ALUsrc2,
		control_ALUop_in => ID_ALUop,
		control_memToReg_in => ID_memToReg,
		control_regWrite_in => ID_regWrite,
		control_memWrite_in => ID_memWrite,
		control_memRead_in => ID_memRead,
		control_WE_in => ID_WC,
		control_TE_in => ID_T_Enable,
		updated_pc_in => ID_PC,
		from_register1_in => ID_register_result1,
		from_register2_in => ID_register_result2,
		from_IH_in => ID_IH,
		from_SP_in => ID_SP, 
		from_imm_exp_in => ID_imm_exp_result,
		from_T_in => ID_T,
		from_instruction_7_5_in => ID_instruction_7_5,
		from_instruction_4_2_in => ID_instruction_4_2,
		from_instruction_10_8_in => ID_instruction_10_8,
		control_branchOrJump_out => ID_EX_branchOrJump,
		control_desRegister_out => ID_EX_disRegister,
		control_ALUsrc1_out => ID_EX_ALUsrc1,
		control_ALUsrc2_out => ID_EX_ALUsrc2,
		control_ALUop_out => ID_EX_ALUop,
		control_memToReg_out => ID_EX_memToReg,
		control_regWrite_out => ID_EX_regWrite,
		control_memWrite_out => ID_EX_memWrite,
		control_memRead_out => ID_EX_memRead,
		control_WE_out => ID_EX_WC,
		control_TE_out => ID_EX_T_Enable,
		updated_pc_out => ID_EX_PC,
		from_register1_out => ID_EX_register_result1,
		from_register2_out => ID_EX_register_result2,
		from_IH_out => ID_EX_IH,
		from_SP_out => ID_EX_SP,
		from_imm_exp_out => ID_EX_imm_exp_result,
		from_T_out => ID_EX_T,
		from_instruction_7_5_out => ID_EX_instruction_7_5,
		from_instruction_4_2_out => ID_EX_instruction_4_2,
		from_instruction_10_8_out => ID_EX_instruction_10_8
	);

	Inst_EX_manager: EX_manager PORT MAP(
		--op1 => tmp1,
		--op2 => tmp2,
		control_desRegister => ID_EX_disRegister,
		control_ALUsrc1 => ID_EX_ALUsrc1,
		control_ALUsrc2 => ID_EX_ALUsrc2,
		control_ALUop => ID_EX_ALUop,
		control_memToReg => ID_EX_memToReg,
		control_regWrite => ID_EX_regWrite,
		control_memWrite => ID_EX_memWrite,
		control_memRead => ID_EX_memRead,
		control_WC => ID_EX_WC,
		--control_TE => ID_EX_T_Enable,
		from_pc => ID_EX_PC,
		register_read_result1 => ID_EX_register_result1,
		register_read_result2 => ID_EX_register_result2,
		from_HI => ID_EX_IH,
		from_SP => ID_EX_SP,
		from_imm_exp => ID_EX_imm_exp_result,
		from_instruction_7_5 => ID_EX_instruction_7_5,
		from_instruction_4_2 => ID_EX_instruction_4_2,
		from_instruction_10_8 => ID_EX_instruction_10_8,
		Fsrc1 => byPass_Fsrc1,
		Fsrc2 => byPass_Fsrc2,
		FmemData => byPass_FmemData,
		result_from_ME_WB => ME_WB_Result,
		result_from_EX_ME => EX_ME_Result,
		out_memToReg => EX_memToReg,
		out_regWrite => EX_regWrite,
		out_memWrite => EX_memWrite,
		out_memRead => EX_memRead,
		out_ALUresult => EX_ALUresult,
		out_mux_writeRamData => EX_wrireData,
		out_mux_target_register => EX_Rtarget,
		out_sum => EX_sum
	);

	Inst_branchControl: branchControl PORT MAP(
		rx => ID_EX_register_result1,
		T => ID_EX_T,
		ME_Value => EX_ME_Result,
		WB_Value => ME_WB_Result,
		BranchOrJump => ID_EX_branchOrJump,
		Fbranch => byPass_Fbranch,
		PC_Choose => branchControl_PC_Choose,
		kill => branchControl_kill
	);

	Inst_byPass: byPass PORT MAP(
		ALUsrc1 => ID_EX_ALUsrc1,
		ALUsrc2 => ID_EX_ALUsrc2,
		ME_ReqWrite => EX_ME_regWrite,
		WB_ReqWrite => ME_WB_regWrite,
		T_Enable => ID_EX_T_Enable,
		rx_addr => ID_EX_instruction_10_8,
		ry_addr => ID_EX_instruction_7_5,
		ME_target => EX_ME_Rtarget,
		WB_target => ME_WB_Rtarget,
		Fsrc1 => byPass_Fsrc1,
		Fsrc2 => byPass_Fsrc2,
		Fbranch => byPass_Fbranch,
		Control_WC => ID_EX_WC,
		FmemData => byPass_FmemData
		
	);
	
	Inst_mux_PC: mux_PC PORT MAP(
		new_PC => IF_PC,
		branch_PC => EX_sum,
		PC_Choose => branchControl_PC_Choose,
		next_PC => mux_PC_PC
	);
	
	Inst_EX_ME: EX_ME PORT MAP(
		clk => clk,
		rst => rst,
		control_memToReg_in => EX_memToReg,
		control_regWrite_in => EX_regWrite,
		control_memRead_in => EX_memRead,
		control_memWrite_in => EX_memWrite,
		from_branch_control_in => branchControl_kill,
		store_data => EX_wrireData,
		target_Addr => EX_Rtarget,
		ALUresult_in => EX_ALUresult,
		control_memToReg_out => EX_ME_memtoReg,
		control_regWrite_out => EX_ME_regWrite,
		control_memRead_out => EX_ME_memRead,
		control_memWrite_out => EX_ME_memWrite,
		from_branch_control_out => EX_ME_kill,
		store_data_out => EX_ME_store_data,
		target_Addr_out => EX_ME_Rtarget,
		ALUresult_out => EX_ME_Result
	);
	
	Inst_ME_manager: ME_manager PORT MAP(
		clk => clk,
		rst => rst,
		control_memToReg_in => EX_ME_memtoReg,
		control_regWrite_in => EX_ME_regWrite,
		control_memWrite_in => EX_ME_memWrite,
		control_memRead_in => EX_ME_memRead,
		control_regWrite_out => ME_regWrite,
		ALUresult => EX_ME_Result,
		store_data => EX_ME_store_data,
		result_out => ME_Result,
		Ram1EN => Ram1EN,
		Ram1OE => Ram1OE,
		Ram1WE => Ram1WE,
		ToRam1_addr => ToRam1_addr(15 downto 0),
		data => Ram1Data,
		wrn => wrn,
		rdn => rdn,
		data_ready => data_ready,
		tbre => tbre,
		tsre => tsre,
		Rtarget_in => EX_ME_Rtarget,
		Rtarget_out => ME_Rtarget
	);

	Inst_ME_WB: ME_WB PORT MAP(
		clk => clk,
		rst => rst,
		regWrite_in => ME_regWrite,
		data_result_in => ME_Result,
		Rtarget_in => ME_Rtarget,
		regWrite_out => ME_WB_regWrite,
		data_result_out => ME_WB_Result,
		Rtarget_out => ME_WB_Rtarget
	);
	
	Inst_translator: translator PORT MAP(
		input_bits => IF_PC(7 downto 0),
		H => DIGITAL_H,
		L => DIGITAL_L
	);

end Behavioral;

