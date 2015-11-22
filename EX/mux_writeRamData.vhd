library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity mux_writeRamData is
	port (
		control_WC: in std_logic;
		from_register1: in std_logic_vector(15 downto 0);
		from_register2: in std_logic_vector(15 downto 0);
		);
end mux_writeRamData;

architecture behavioral of mux_writeRamData is

begin

end architecture ; -- behavioral