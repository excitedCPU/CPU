library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T is
port(
	regWrite: in std_logic_vector(2 downto 0);
	writeData: in std_logic_vector(15 downto 0);

	TData: out std_logic_vector(15 downto 0)
);
end T;

architecture behavioral of T is
begin
	process(regWrite, writeData)
	begin
		if (regWrite = "001") then
			TData <= writeData;
		end if;
	end process;
end architecture ; -- behavioral