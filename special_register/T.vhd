library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T is
port(
	clk: in std_logic;
	rst: in std_logic;
	regWrite: in std_logic_vector(2 downto 0);
	writeData: in std_logic_vector(15 downto 0);

	TData: out std_logic_vector(15 downto 0)
);
end T;

architecture behavioral of T is
begin
	process(regWrite, writeData, clk, rst)
	begin
		if (rst = '0') then
			TData <= (others => '0');
		elsif (regWrite = "001" and rising_edge(clk)) then
			TData <= writeData;
		end if;
	end process;
end architecture ; -- behavioral