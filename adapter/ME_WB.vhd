library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ME_WB is
	port (
		clk, rst: in std_logic;
		regWrite_in: in std_logic_vector(2 downto 0);
		data_result_in: in std_logic_vector(15 downto 0);
		Rtarget_in: in std_logic_vector(2 downto 0);

		regWrite_out: out std_logic_vector(2 downto 0);
		data_result_out: out std_logic_vector(15 downto 0);
		Rtarget_out: out std_logic_vector(2 downto 0)
		);
end ME_WB;

architecture behavioral of ME_WB is
begin
	process(clk, rst)
	begin
		if rst = '0' then --FIX
			regWrite_out <= "100";
			data_result_out <= "0000000000000000";
			Rtarget_out <= "000";
		elsif clk'event and clk = '0' then
			regWrite_out <= regWrite_in;
			data_result_out <= data_result_in;
			Rtarget_out <= Rtarget_in;
		end if;
	end process;
end architecture ; -- behavioral