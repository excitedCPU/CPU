library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity instructionRegister is
	port (
		pc: in std_logic_vector(15 downto 0);
		instruction: out std_logic_vector(15 downto 0)
		);
end instructionRegister;

architecture behavioral of instructionRegister is

begin

end architecture ; -- behavioral