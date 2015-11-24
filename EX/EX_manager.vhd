library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_manager is
	port (
		control_branchOrJump: in std_logic_vector(2 downto 0);
		control_desRegister: in std_logic_vector(1 downto 0);
		control_ALUsrc1: in std_logic_vector(2 downto 0);
		control_ALUsrc2: in std_logic_vector(2 downto 0);
		control_ALUop: in std_logic_vector(3 downto 0);
		control_memToReg: in std_logic_vector(2 downto 0);
		control_regWrite: in std_logic_vector(2 downto 0);
		control_memWrite: in std_logic;
		control_memRead: in std_logic;
		control_WE: in std_logic;
		control_TE: in std_logic;
		updated_pc: in std_logic_vector(15 downto 0);
		from_HI: in std_logic_vector(15 downto 0);
		from_SP: in std_logic_vector(15 downto 0);
		from_imm_exp: in std_logic_vector(15 downto 0);
		from_T: in std_logic_vector(15 downto 0);
		from_instruction_7_5: in std_logic_vector(2 downto 0);
		from_instruction_4_2: in std_logic_vector(2 downto 0);
		from_instruction_10_8: in std_logic_vector(2 downto 0);
		Fsrc1: in std_logic_vector(1 downto 0);
		Fsrc2: in std_logic_vector(1 downto 0);
		result_from_ME_WB: in std_logic_vector(15 downto 0);
		result_from_EX_ME: in std_logic_vector(15 downto 0);
		register_read_result1: in std_logic_vector(15 downto 0);
		register_read_result2: in std_logic_vector(15 downto 0);


		out_memToReg: out std_logic_vector(2 downto 0);
		out_regWrite: out std_logic_vector(2 downto 0);
		out_memWrite: out std_logic;
		out_memRead: out std_logic;
		out_ALUresult: out std_logic_vector(15 downto 0);
		out_mux_writeRamData: out std_logic_vector(15 downto 0);
		out_mux_desRegister: out std_logic_vector(15 downto 0);
		out_from_instruction_10_8: out std_logic_vector(2 downto 0);
		out_from_instruction_7_5: out std_logic_vector(2 downto 0);
		out_byPass_to_branchControl: out std_logic;
		out_ID_EX_to_branchControl: out std_logic;
		out_control_branchOrJump: out std_logic_vector(2 downto 0);
		out_register_read_result1: out std_logic_vector(15 downto 0);
		out_sum: out std_logic_vector(15 downto 0);
		);
end EX_manager;

architecture structural of EX_manager is
	COMPONENT ALU
	PORT(
		ALUsrc1 : IN std_logic_vector(15 downto 0);
		ALUsrc2 : IN std_logic_vector(15 downto 0);
		control_ALUop : IN std_logic_vector(3 downto 0);          
		result : OUT std_logic_vector(15 downto 0);
		sum : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT mux_ALUsrc
	PORT(
		control_ALUsrc : IN std_logic_vector(2 downto 0);
		control_Fsrc : IN std_logic_vector(1 downto 0);
		from_pc : IN std_logic_vector(15 downto 0);
		from_HI : IN std_logic_vector(15 downto 0);
		from_SP : IN std_logic_vector(15 downto 0);
		from_EX_ME : IN std_logic_vector(15 downto 0);
		from_ME_WB : IN std_logic_vector(15 downto 0);
		from_imm_exp : IN std_logic_vector(15 downto 0);
		from_register : IN std_logic_vector(15 downto 0);          
		result : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT mux_desRegister
	PORT(
		instruction_7_5 : IN std_logic_vector(2 downto 0);
		instruction_4_2 : IN std_logic_vector(2 downto 0);
		instruction_10_8 : IN std_logic_vector(2 downto 0);
		control_regDest : IN std_logic_vector(1 downto 0);          
		desRegister : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	COMPONENT mux_writeRamData
	PORT(
		control_WC : IN std_logic;
		from_register1 : IN std_logic_vector(15 downto 0);
		from_register2 : IN std_logic_vector(15 downto 0);          
		result : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	--inner signal
	signal alu_src1: std_logic_vector(15 downto 0);
	signal alu_src2: std_logic_vector(15 downto 0);
begin
	Inst_ALU: ALU PORT MAP(
		ALUsrc1 => alu_src1,
		ALUsrc2 => alu_src2,
		control_ALUop => control_ALUop,
		result => out_ALUresult,
		sum => out_sum
	);
	Inst_mux_ALUsrc1: mux_ALUsrc PORT MAP(
		control_ALUsrc => control_ALUsrc1,
		control_Fsrc => Fsrc1,
		from_pc => updated_pc,
		from_HI => from_HI,
		from_SP => from_SP,
		from_EX_ME => result_from_EX_ME,
		from_ME_WB => result_from_ME_WB,
		from_imm_exp => from_imm_exp,
		from_register => register_read_result1,
		result => alu_src1
	);
	Inst_mux_ALUsrc2: mux_ALUsrc PORT MAP(
		control_ALUsrc => control_ALUsrc2,
		control_Fsrc => Fsrc2,
		from_pc => updated_pc,
		from_HI => from_HI,
		from_SP => from_SP,
		from_EX_ME => result_from_EX_ME,
		from_ME_WB => result_from_ME_WB,
		from_imm_exp => from_imm_exp,
		from_register => register_read_result2,
		result => alu_src2
	);
	Inst_mux_desRegister: mux_desRegister PORT MAP(
		instruction_7_5 => from_instruction_7_5,
		instruction_4_2 => from_instruction_4_2,
		instruction_10_8 => from_instruction_10_8,
		control_regDest => control_desRegister,
		desRegister => 
	);
	Inst_mux_writeRamData: mux_writeRamData PORT MAP(
		control_WC => ,
		from_register1 => ,
		from_register2 => ,
		result => 
	);
end architecture ; -- structural