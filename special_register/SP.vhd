library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SP is
port(
	clk: in std_logic;
	rst: in std_logic;
	regWrite: in std_logic_vector(2 downto 0);
	writeData: in std_logic_vector(15 downto 0);

	SPData: out std_logic_vector(15 downto 0)
);
end SP;

architecture behavioral of SP is
begin
	process(regWrite, writeData, clk, rst)
	begin
		if (rst = '0') then
			SPData <= (others => '0');
		elsif (regWrite = "011" and rising_edge(clk)) then
			SPData <= writeData;
		end if;
	end process;
end architecture ; -- behavioral