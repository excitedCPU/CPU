library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--6.823ns
entity mux_writeRamData is
	port (
		control_WC: in std_logic;
		FmemData: in std_logic_vector(1 downto 0);
		from_register1: in std_logic_vector(15 downto 0);
		from_register2: in std_logic_vector(15 downto 0);
		from_ME_Data: in std_logic_vector(15 downto 0);
		from_WB_Data: in std_logic_vector(15 downto 0);
		result: out std_logic_vector(15 downto 0)
		);
end mux_writeRamData;

architecture behavioral of mux_writeRamData is
begin

	result <= from_register1 when FmemData = "00" and control_WC = '0' else
		      from_register2 when FmemData = "00" and control_WC = '1' else
			  from_ME_Data when FmemData = "01" else
			  from_WB_Data when FmemData = "10" else
			  "0000000000000000";

--	process(control_WC, from_register1, from_register2)
--	begin
--		if (FmemData = "00") then 
--			if control_WC = '0' then
--				result <= from_register1;
--			elsif control_WC = '1' then
--				result <= from_register2;
--			end if;
--		elsif (FmemData = "01") then
--			result <= from_ME_Data;
--		elsif (FmemData = "10") then
--			result <= from_WB_Data;
--		end if;
--	end process;
end architecture ; -- behavioral