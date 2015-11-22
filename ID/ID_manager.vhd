library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity ID_manager is
	port (
		instruction: in std_logic_vector(15 downto 0);
		updated_PC_in: in std_logic_vector(15 downto 0);
		branchOrJump: out std_logic_vector(2 downto 0);
		desRegister: out std_logic_vector(1 downto 0);
		ALUsrc1: out std_logic_vector(2 downto 0);
		ALUsrc2: out std_logic_vector(2 downto 0);
		ALUop: out std_logic_vector(3 downto 0);
		memToReg: out std_logic_vector(2 downto 0);
		regWrite: out std_logic_vector(2 downto 0);
		memWrite: out std_logic;
		memRead: out std_logic;
		updated_PC_out: out std_logic_vector(15 downto 0);
		register_result1: out std_logic_vector(15 downto 0);
		register_result2: out std_logic_vector(15 downto 0);
		imm_exp_result: out std_logic_vector(15 downto 0);
		instruction_7_5: out std_logic_vector(2 downto 0);
		instruction_4_2: out std_logic_vector(2 downto 0);
		instruction_10_8: out std_logic_vector(2 downto 0);
		);
end ID_manager;

architecture behavioral of ID_manager is

begin

end architecture ; -- behavioral