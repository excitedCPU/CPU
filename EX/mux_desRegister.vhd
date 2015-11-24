library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--6.779ns
entity mux_desRegister is
	port(
		instruction_7_5: in std_logic_vector(2 downto 0);
		instruction_4_2: in std_logic_vector(2 downto 0);
		instruction_10_8: in std_logic_vector(2 downto 0);
		control_regDest: in std_logic_vector(1 downto 0);
		desRegister: out std_logic_vector(2 downto 0)
		);
end mux_desRegister;

architecture behavioral of mux_desRegister is
begin
	process(control_regDest, instruction_7_5, instruction_4_2, instruction_10_8)
	begin
		case control_regDest is
		when "00" => --rx
			desRegister <= instruction_10_8; 
		when "01" => --ry
			desRegister <= instruction_7_5;
		when "10" => --rz
			desRegister <= instruction_4_2;
		when others => --no target
			desRegister <= "000";
		end case;
	end process;
end architecture ; -- behavioral