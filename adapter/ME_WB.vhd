library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_WB is
	port (
		clk, rst: in std_logic;
		regWrite_in: in std_logic_vector(2 downto 0);
		data_result_in: in std_logic_vector(15 downto 0);
		desReg_in: in std_logic_vector(2 downto 0);

		regWrite_out: out std_logic_vector(2 downto 0);
		data_result_out: out std_logic_vector(15 downto 0);
		desReg_out: out std_logic_vector(2 downto 0)
		);
end EX_WB;

architecture behavioral of EX_WB is
begin
	process(clk, rst)
	begin
		if rst = '1' then
			regWrite_out <= "000";
			data_result_out <= "0000000000000000";
			desReg_out <= "000";
		elsif clk'event and clk = '1' then
			regWrite_out <= regWrite_in;
			data_result_out <= data_result_in;
			desReg_out <= desReg_in;
		end if;
	end process;
end architecture ; -- behavioral