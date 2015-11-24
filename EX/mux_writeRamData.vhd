library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--6.823ns
entity mux_writeRamData is
	port (
		control_WC: in std_logic;
		from_register1: in std_logic_vector(15 downto 0);
		from_register2: in std_logic_vector(15 downto 0);
		result: out std_logic_vector(15 downto 0)
		);
end mux_writeRamData;

architecture behavioral of mux_writeRamData is
begin
	process(control_WC, from_register1, from_register2)
	begin
		if control_WC = '0' then
			result <= from_register1;
		elsif control_WC = '1' then
			result <= from_register2;
		end if;
	end process;
end architecture ; -- behavioral