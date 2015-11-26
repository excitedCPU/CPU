library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IH is
port(
	regWrite: in std_logic_vector(2 downto 0);
	writeData: in std_logic_vector(15 downto 0);

	IHData: out std_logic_vector(15 downto 0)
);
end IH;

architecture behavioral of IH is
begin
	process(regWrite, writeData)
	begin
		if (regWrite = "010") then
			IHData <= writeData;
		end if;
	end process;
end architecture ; -- behavioral