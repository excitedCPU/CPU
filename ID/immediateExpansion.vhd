library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity immediateExpansion is
	port (
		instruction: in std_logic_vector(15 downto 0);
		imm_exp_result: out std_logic_vector(15 downto 0);
		);

end immediateExpansion;

architecture behavioral of immediateExpansion is

begin

end architecture ; -- behavioral