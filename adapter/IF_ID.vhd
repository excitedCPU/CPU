library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--4.283ns
entity IF_ID is
	port (
		clk, rst: in std_logic;
		from_riskCheck: in std_logic;
		updated_pc_in: in std_logic_vector(15 downto 0);
		instruction_in: in std_logic_vector(15 downto 0);
		updated_pc_out: out std_logic_vector(15 downto 0);
		instruction_out: out std_logic_vector(15 downto 0)
		);
end IF_ID;

architecture behavioral of IF_ID is
begin
	process (clk, rst)
	begin
		if rst = '0' then
			updated_pc_out <= "0000000000000000"; --16bit
			instruction_out <= "0000100000000000"; --16bit
		elsif clk'event and clk = '0' then
			if (from_riskCheck = '0') then --'0' enable to write
				updated_pc_out <= updated_pc_in;
				instruction_out <= instruction_in;
			end if;
		end if;
	end process;

end architecture ; -- behavioral