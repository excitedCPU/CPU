library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity IF_manager is
	port (
		old_pc: in std_logic_vector(15 downto 0);
		new_pc: out std_logic_vector(15 downto 0);
		instruction: out std_logic_vector(15 downto 0);
		);
end IF_manager;

architecture behavioral of IF_manager is

begin

end architecture ; -- behavioral