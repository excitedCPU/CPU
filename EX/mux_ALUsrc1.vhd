library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity mux_ALUsrc1 is
	port(
		control_ALUsrc1: in std_logic_vector(2 downto 0);
		from_pc: in std_logic_vector(15 downto 0);
		from_HI_SP: in std_logic_vector(15 downto 0);
		from_EX_ME: in std_logic_vector(15 downto 0);
		from_ME_WB: in std_logic_vector(15 downto);
		from_imm_exp: in std_logic_vector(15 downto 0);
		from_register1: in std_logic_vector(15 downto 0);
		result: out std_logic_vector(15 downto 0)
		);
end mux_ALUsrc1;

architecture behavioral of mux_ALUsrc1 is

begin

end architecture ; -- behavioral