library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_PC is
port(
	new_PC: in std_logic_vector(15 downto 0);
	branch_PC: in std_logic_vector(15 downto 0);
	PC_Choose: in std_logic;

	next_PC: out std_logic_vector(15 downto 0)
);
end mux_PC;

architecture behavioral of mux_PC is
begin
	process(PC_Choose, branch_PC, new_PC)
	begin
		if (PC_Choose = '1') then
			next_PC <= branch_PC;
		else
			next_PC <= new_PC;
		end if;
	end process;
end architecture ; -- behavioral