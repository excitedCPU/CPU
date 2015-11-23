library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity adder is
	port (
		old_pc: in std_logic_vector(15 downto 0);
		new_pc: out std_logic_vector(15 downto 0)
		);
end adder;

architecture behavioral of adder is
begin
	new_pc <= old_pc + "0000000000000001";
end architecture ; -- behavioral