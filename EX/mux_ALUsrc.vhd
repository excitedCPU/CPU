library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--11.941
entity mux_ALUsrc is
	port(
		control_ALUsrc: in std_logic_vector(2 downto 0);
		control_Fsrc: in std_logic_vector(1 downto 0);
		from_pc: in std_logic_vector(15 downto 0);
		from_HI: in std_logic_vector(15 downto 0);
		from_SP: in std_logic_vector(15 downto 0);
		from_EX_ME: in std_logic_vector(15 downto 0);
		from_ME_WB: in std_logic_vector(15 downto 0);
		from_imm_exp: in std_logic_vector(15 downto 0);
		from_register: in std_logic_vector(15 downto 0);
		result: out std_logic_vector(15 downto 0)
		);
end mux_ALUsrc;

architecture behavioral of mux_ALUsrc is

begin
	process(control_ALUsrc, control_Fsrc, from_pc, from_HI, from_SP, from_EX_ME, from_ME_WB, from_imm_exp, from_register)
	begin
		case control_Fsrc is
		when "00" => --no bypass
			case control_ALUsrc is
			when "000" => --from register
				result <= from_register;
			when "001" => --from imm
				result <= from_imm_exp;
			when "010" => --from SP
				result <= from_SP;
			when "100" => --from HI
				result <= from_HI;
			when "011" => --from pc
				result <= from_pc;
			when "111" => --all zeros
				result <= "0000000000000000"; --16bit
			when others =>
				result <= "0000000000000000"; --16bit
			end case;
		when "01" => --memory
			result <= from_EX_ME;
		when "10" => --writeback
			result <= from_ME_WB;
		when others =>
			result <= "0000000000000000"; --16bit
		end case;
	end process;
end architecture ; -- behavioral