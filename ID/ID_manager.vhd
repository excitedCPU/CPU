library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ID_manager is
	port (
		instruction: in std_logic_vector(15 downto 0);
		updated_PC_in: in std_logic_vector(15 downto 0);
		write_addr: in std_logic_vector(2 downto 0);
		write_data: in std_logic_vector(15 downto 0);
		register_write_enable: in std_logic;
		control_clear_instruction: in std_logic;	--(from branch control)when its '1', instruction shall be set to Nop

		branchOrJump: out std_logic_vector(2 downto 0);
		desRegister: out std_logic_vector(1 downto 0);
		ALUsrc1: out std_logic_vector(2 downto 0);
		ALUsrc2: out std_logic_vector(2 downto 0);
		ALUop: out std_logic_vector(3 downto 0);
		memToReg: out std_logic;
		regWrite: out std_logic_vector(2 downto 0);
		memWrite: out std_logic;
		memRead: out std_logic;
		updated_PC_out: out std_logic_vector(15 downto 0);
		register_result1: out std_logic_vector(15 downto 0);
		register_result2: out std_logic_vector(15 downto 0);
		imm_exp_result: out std_logic_vector(15 downto 0);
		instruction_7_5: out std_logic_vector(2 downto 0);
		instruction_4_2: out std_logic_vector(2 downto 0);
		instruction_10_8: out std_logic_vector(2 downto 0)
		);
end ID_manager;

architecture structural of ID_manager is
	COMPONENT commonRegister
	PORT(
		read_rx : IN std_logic_vector(2 downto 0);
		read_ry : IN std_logic_vector(2 downto 0);
		write_addr : IN std_logic_vector(2 downto 0);
		write_data : IN std_logic_vector(15 downto 0);
		write_enable : IN std_logic;          
		read_result1 : OUT std_logic_vector(15 downto 0);
		read_result2 : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT immediateExpansion
	PORT(
		instruction : IN std_logic_vector(15 downto 0);          
		imm_exp_result : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
begin
	Inst_commonRegister: commonRegister PORT MAP(
		read_rx => instruction(10 downto 8),
		read_ry => instruction(7 downto 5),
		write_addr => write_addr,
		write_data => write_data,
		write_enable => register_write_enable,
		read_result1 => register_result1,
		read_result2 => register_result2
	);
	Inst_immediateExpansion: immediateExpansion PORT MAP(
		instruction => instruction,
		imm_exp_result => imm_exp_result
	);
end architecture ; -- structural