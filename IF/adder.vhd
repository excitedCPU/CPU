library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity adder is
	port (
		old_pc: in std_logic_vector(15 downto 0);
		new_pc: out std_logic_vector(15 downto 0)
		);
end adder;

architecture behavioral of adder is

begin

end architecture ; -- behavioral