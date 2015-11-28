library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IH is
port(
	clk: in std_logic;
	rst: in std_logic;
	regWrite: in std_logic_vector(2 downto 0);
	writeData: in std_logic_vector(15 downto 0);

	IHData: out std_logic_vector(15 downto 0)
);
end IH;

architecture behavioral of IH is
begin
	process(rst, clk, regWrite, writeData)
	begin
		if (rst = '0') then
			IHdata <= (others => '0');
		elsif (regWrite = "010" and rising_edge(clk)) then
			IHData <= writeData;
		end if;
	end process;
end architecture ; -- behavioral