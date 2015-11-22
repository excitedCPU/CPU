library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity alu is
	port (
		ALUsrc1: in std_logic_vector(15 downto 0);
		ALUsrc2: in std_logic_vector(15 downto 0);
		control_ALUop: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(15 downto 0)
		);
end alu;

architecture behavioral of alu is

begin

end architecture ; -- behavioral