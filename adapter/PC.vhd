library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--4.283ns
entity PC is
	port (
		clk: in std_logic;
		rst: in std_logic;
		from_mux_pc: in std_logic_vector(15 downto 0);
		To_Keep: in std_logic;
		pc_out: out std_logic_vector(15 downto 0)
		);
end PC;

architecture behavioral of PC is
begin
	process (clk, rst)
	begin
		if rst = '0' then
			pc_out <= "0000000000000000"; --16bit
		elsif clk'event and clk = '0' then
			if To_Keep = '0' then --0 is enable
				pc_out <= from_mux_pc;
			end if;
		end if;
	end process;
end architecture ; -- behavioral