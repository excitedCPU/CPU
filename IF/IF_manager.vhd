library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IF_manager is
	port (
		old_pc: in std_logic_vector(15 downto 0);
		new_pc: out std_logic_vector(15 downto 0);
		instruction: out std_logic_vector(15 downto 0)
		);
end IF_manager;

architecture structural of IF_manager is
	COMPONENT adder
	PORT(
		old_pc : IN std_logic_vector(15 downto 0);          
		new_pc : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT instructionMemory
	PORT(
		pc : IN std_logic_vector(15 downto 0);          
		instruction : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
begin
	Inst_adder: adder PORT MAP(
		old_pc => old_pc,
		new_pc => new_pc
	);
	Inst_instructionMemory: instructionMemory PORT MAP(
		pc => old_pc,
		instruction => instruction
	);
end architecture ; -- structural