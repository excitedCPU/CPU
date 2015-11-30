library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instruction_MEM is
port (
	clk: in std_logic;
	rst: in std_logic;

	read_Enable: in std_logic;
	write_Enable: in std_logic;
	write_Data: in std_logic_vector(15 downto 0);
	target_Addr: in std_logic_vector(15 downto 0);

	RAddr: in std_logic_vector(15 downto 0);
	Rdata: out std_logic_vector(15 downto 0);
	
	data: inout std_logic_vector(15 downto 0);
	ToRam_addr: out std_logic_vector(15 downto 0);

	IRamEN: out std_logic;
	IRamOE: out std_logic;
	IRamWE: out std_logic
);
end Instruction_MEM;

architecture behavioral of Instruction_MEM is
begin
	IRamEN <= '0';
	IRamOE <= write_Enable;
	IRamWE <= not (write_Enable and clk);

	Rdata <= data;

	process (clk)
	begin
		if (rising_edge(clk)) then
			if (write_Enable = '0') then
				if (read_Enable = '0') then
					ToRam_addr <= RAddr;
					data <= (others => 'Z');
				elsif (read_Enable = '1') then
					ToRam_addr <= target_Addr;
					data <= (others => 'Z');
				end if;
			elsif (write_Enable = '1') then
				ToRam_addr <= target_Addr;
				data <= write_Data;
			end if;
		end if;
	end process;

	
end architecture;