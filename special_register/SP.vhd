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
begin
	process(regWrite, writeData)
	begin
		if (regWrite = "011") then
			SPData <= writeData;
		end if;
	end process;
end architecture ; -- behavioral