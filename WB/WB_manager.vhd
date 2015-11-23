library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WB_manager is
	port (
		ME_result_in: in std_logic_vector(15 downto 0);
		control_regWrite_in: in std_logic_vector(2 downto 0);
		write_register_addr_in: in std_logic_vector(15 downto 0);

		to_T: out std_logic_vector(15 downto 0);
		to_HI: out std_logic_vector(15 downto 0);
		to_SP: out std_logic_vector(15 downto 0);
		control_regWrite_addr_out: out std_logic_vector(2 downto 0)
		);
end WB_manager;

architecture behavioral of WB_manager is

begin
	to_T <= ME_result_in;
	to_HI <= ME_result_in;
	to_SP <= ME_result_in;
	control_regWrite_addr_out <= control_regWrite_in;
end behavioral ; -- behavioral