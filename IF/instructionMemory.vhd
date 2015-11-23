library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instructionMemory is
	port (
		pc: in std_logic_vector(15 downto 0);
		instruction: out std_logic_vector(15 downto 0)
		);
end instructionMemory;

architecture behavioral of instructionMemory is

begin
	

end architecture ; -- behavioral