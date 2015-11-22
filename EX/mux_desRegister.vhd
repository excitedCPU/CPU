library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity mux_desRegister is
	port(
		instruction_7_5: in std_logic_vector(2 downto 0);
		instruction_4_2: in std_logic_vector(2 downto 0);
		instruction_10_8: in std_logic_vector(2 downto 0);
		control_regDest: in std_logic_vector(1 downto 0);
		desRegister: out std_logic_vector(2 downto 0)
		);
end mux_desRegister;

architecture behavioral of mux_desRegister is

begin

end architecture ; -- behavioral