library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity controlUnit is
	port (
		instruction: in std_logic_vector(15 downto 0);
		from_risk_check: in std_logic;
		from_branch_control: in std_logic;
		branchOrJump: out std_logic_vector(2 downto 0);
		desRegister: out std_logic_vector(1 downto 0);
		ALUsrc1: out std_logic_vector(2 downto 0);
		ALUsrc2: out std_logic_vector(2 downto 0);
		ALUop: out std_logic_vector(3 downto 0);
		memToReg: out std_logic_vector(2 downto 0);
		regWrite: out std_logic_vector(2 downto 0);
		memWrite: out std_logic;
		memRead: out std_logic
		);

end controlUnit;

architecture behavioral of controlUnit is

begin

end architecture ; -- behavioral

package C_SIGNAL is
	CONSTANT TEST_SIGNAL: std_logic_vector(2 downto 0) := "111";
end C_SIGNAL;