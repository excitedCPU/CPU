library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity EX_WB is
	port (
		regWrite_in: in std_logic_vector(2 downto 0);
		data_result_in: in std_logic_vector(15 downto 0);
		desReg_in: in std_logic_vector(2 downto 0);

		regWrite_out: out std_logic_vector(2 downto 0);
		data_result_out: out std_logic_vector(15 downto 0);
		desReg_out: out std_logic_vector(2 downto 0);
		);
end EX_WB;

architecture behavioral of EX_WB is

begin

end architecture ; -- behavioral