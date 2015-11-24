library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
	port (
		ALUsrc1: in std_logic_vector(15 downto 0);
		ALUsrc2: in std_logic_vector(15 downto 0);
		control_ALUop: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(15 downto 0)
		);
end alu;

architecture behavioral of alu is
begin
	process(ALUsrc1, ALUsrc2, control_ALUop)
	begin
		case control_ALUop is
			when "0000" => --ADD 
			when "0001" => --AND
			when "0100" => --equal
			when "0101" => --directly assign 
			when "0110" => --OR 
			when "0111" => --equal then shift left
			when "1000" => --equal then
			when "1001" => --equal then shift right 
			when "1010" => --shift right 
			when "1011" => --minus
			when "1110" => --assign first opnum
			when "1111" => --assign second opnum
			when others => --zero
				result <= "0000000000000000";
		end case;
	end process;

end architecture ; -- behavioral