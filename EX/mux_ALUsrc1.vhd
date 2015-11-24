library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_ALUsrc1 is
	port(
		control_ALUsrc1: in std_logic_vector(2 downto 0);
		from_pc: in std_logic_vector(15 downto 0);
		from_HI_SP: in std_logic_vector(15 downto 0);
		from_EX_ME: in std_logic_vector(15 downto 0);
		from_ME_WB: in std_logic_vector(15 downto 0);
		from_imm_exp: in std_logic_vector(15 downto 0);
		from_register1: in std_logic_vector(15 downto 0);
		result: out std_logic_vector(15 downto 0)
		);
end mux_ALUsrc1;

architecture behavioral of mux_ALUsrc1 is

begin
	process(control_ALUsrc1, from_pc, from_HI_SP, from_EX_ME, from_ME_WB, from_imm_exp, from_register1)
		case control_ALUsrc1 is
			when "000" => --from register
				result <= from_register1;
			when "001" => --from imm
				result <= from_imm_exp;
			when "010" => --from 
			when "011" => --from pc
				result <= from_pc;
			when ""
		end case;
	end process;
end architecture ; -- behavioral