library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity mux_ALUsrc2 is
	port(
		control_ALUsrc2: in std_logic_vector(2 downto 0);
		from_pc: in std_logic_vector(15 downto 0);
		from_HI_SP: in std_logic_vector(15 downto 0);
		from_EX_ME: in std_logic_vector(15 downto 0);
		from_ME_WB: in std_logic_vector(15 downto);
		from_imm_exp: in std_logic_vector(15 downto 0);
		from_register2: in std_logic_vector(15 downto 0);
		result: out std_logic_vector(15 downto 0)
		);
end mux_ALUsrc2;

architecture behavioral of mux_ALUsrc2 is

begin

end architecture ; -- behavioral