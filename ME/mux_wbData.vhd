library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity mux_wbData is
	port (
		control_memToReg: in std_logic;
		ALUresult: in std_logic_vector(15 downto 0);
		ramResult: in std_logic_vector(15 downto 0);
		result: out std_logic_vector(15 downto 0)
		);
end mux_wbData;

architecture behavioral of mux_wbData is

begin

end architecture ; -- behavioral