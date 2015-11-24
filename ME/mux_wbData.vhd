library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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

process(control_memToReg, ALUresult, ramResult)
begin
	if control_memToReg = '0' then
		result <= ALUresult;
	elsif control_memToReg = '1' then
		result <= ramResult;
	end if;
end process;

end architecture ; -- behavioral