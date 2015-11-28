library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ID_manager is
	port (
		clk: in std_logic;
		rst: in std_logic;
		instruction: in std_logic_vector(15 downto 0);
		from_PC: in std_logic_vector(15 downto 0);
		write_addr: in std_logic_vector(2 downto 0);
		write_data: in std_logic_vector(15 downto 0);
		regWrite: in std_logic_vector(2 downto 0);
		from_branch_control: in std_logic;	
		from_risk_check: in std_logic;

		out_branchOrJump: out std_logic_vector(2 downto 0);
		out_desRegister: out std_logic_vector(1 downto 0);
		out_ALUsrc1: out std_logic_vector(2 downto 0);
		out_ALUsrc2: out std_logic_vector(2 downto 0);
		out_ALUop: out std_logic_vector(3 downto 0);
		out_memToReg: out std_logic;
		out_regWrite: out std_logic_vector(2 downto 0);
		out_memWrite: out std_logic;
		out_memRead: out std_logic;
		out_WC: out std_logic;
		out_T_Enable: out std_logic;
		PC_result: out std_logic_vector(15 downto 0);
		register_result1: out std_logic_vector(15 downto 0);
		register_result2: out std_logic_vector(15 downto 0);
		imm_exp_result: out std_logic_vector(15 downto 0);
		IH_result: out std_logic_vector(15 downto 0);
		SP_result: out std_logic_vector(15 downto 0);
		T_result: out std_logic_vector(15 downto 0);
		instruction_7_5: out std_logic_vector(2 downto 0);
		instruction_4_2: out std_logic_vector(2 downto 0);
		instruction_10_8: out std_logic_vector(2 downto 0);
		
		out_register1: out std_logic_vector(15 downto 0);--debug
		out_register2: out std_logic_vector(15 downto 0)--debug
		);
end ID_manager;

architecture structural of ID_manager is
	COMPONENT IH
	PORT(
		clk: IN std_logic;
		rst: In std_logic;
		regWrite : IN std_logic_vector(2 downto 0);
		writeData : IN std_logic_vector(15 downto 0);          
		IHData : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SP
	PORT(
		clk: IN std_logic;
		rst: In std_logic;
		regWrite : IN std_logic_vector(2 downto 0);
		writeData : IN std_logic_vector(15 downto 0);          
		SPData : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	COMPONENT T
	PORT(
		clk: IN std_logic;
		rst: In std_logic;
		regWrite : IN std_logic_vector(2 downto 0);
		writeData : IN std_logic_vector(15 downto 0);          
		TData : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT commonRegister
	PORT(
		clk: IN std_logic;
		rst : IN std_logic;
		read_rx : IN std_logic_vector(2 downto 0);
		read_ry : IN std_logic_vector(2 downto 0);
		write_addr : IN std_logic_vector(2 downto 0);
		write_data : IN std_logic_vector(15 downto 0);
		regWrite : IN std_logic_vector(2 downto 0);          
		read_result1 : OUT std_logic_vector(15 downto 0);
		read_result2 : OUT std_logic_vector(15 downto 0);
		out_register1: OUT std_logic_vector(15 downto 0);--debug
		out_register2: OUT std_logic_vector(15 downto 0)--debug
		);
	END COMPONENT;
	
	COMPONENT immediateExpansion
	PORT(
		instruction : IN std_logic_vector(15 downto 0);          
		imm_exp_result : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	COMPONENT controlUnit is
	port (
		instruction: in std_logic_vector(15 downto 0);
		from_risk_check: in std_logic;
		from_branch_control: in std_logic;

		branchOrJump: out std_logic_vector(2 downto 0);
		desRegister: out std_logic_vector(1 downto 0);
		ALUsrc1: out std_logic_vector(2 downto 0);
		ALUsrc2: out std_logic_vector(2 downto 0);
		ALUop: out std_logic_vector(3 downto 0);
		memToReg: out std_logic;
		regWrite: out std_logic_vector(2 downto 0);
		memWrite: out std_logic;
		memRead: out std_logic;
		WC: out std_logic;
		T_Enable: out std_logic
		);

	end COMPONENT;
	
begin
	Inst_commonRegister: commonRegister PORT MAP(
		clk => clk,
		rst => rst,
		read_rx => instruction(10 downto 8),
		read_ry => instruction(7 downto 5),
		write_addr => write_addr,
		write_data => write_data,
		regWrite => regWrite,
		read_result1 => register_result1,
		read_result2 => register_result2,
		out_register1 => out_register1,--debug
		out_register2 => out_register2--debug
	);

	Inst_immediateExpansion: immediateExpansion PORT MAP(
		instruction => instruction,
		imm_exp_result => imm_exp_result
	);

	Inst_controlUnit: controlUnit PORT MAP(
		instruction => instruction,
		from_risk_check => from_risk_check,
		from_branch_control => from_branch_control,

		branchOrJump => out_branchOrJump,
		desRegister => out_desRegister,
		ALUsrc1 => out_ALUsrc1,
		ALUsrc2 => out_ALUsrc2,
		ALUop => out_ALUop,
		memToReg => out_memToReg,
		regWrite => out_regWrite,
		memWrite => out_memWrite,
		memRead => out_memRead,
		WC => out_WC,
		T_Enable => out_T_Enable
	);

	Inst_IH: IH PORT MAP(
		clk => clk,
		rst => rst,
		regWrite => regWrite,
		writeData => write_data,
		IHData => IH_result
	);

	Inst_SP: SP PORT MAP(
		clk => clk,
		rst => rst,
		regWrite => regWrite,
		writeData => write_data,
		SPData => SP_result
	);

	Inst_T: T PORT MAP(
		clk => clk,
		rst => rst,
		regWrite => regWrite,
		writeData => write_data,
		TData => T_result
	);	

	PC_result <= from_PC;
	instruction_10_8 <= instruction(10 downto 8);
	instruction_7_5 <= instruction(7 downto 5);
	instruction_4_2 <= instruction(4 downto 2); 
end architecture ; -- structural