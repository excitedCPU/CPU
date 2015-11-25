library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SP is
port(
	regWrite: in std_logic_vector(2 downto 0);
	writeData: in std_logic_vector(15 downto 0);

	SPData: out std_logic_vector(15 downto 0)
);
end SP;

architecture behavioral of SP is
	shared variable SP_register: std_logic_vector(15 downto 0);
begin
	process(regWrite)
	begin
		if (regWrite = "011") then
			SP_register := writeData;
		end if;
	end process;

	SPData <= SP_register;
end architecture ; -- behavioral