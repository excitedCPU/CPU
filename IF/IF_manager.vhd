library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IF_manager is
	port (
		clk: in std_logic;
		rst: in std_logic;
		old_pc: in std_logic_vector(15 downto 0);
		new_pc: out std_logic_vector(15 downto 0);
		Instruction: out std_logic_vector(15 downto 0);

		write_enable: in std_logic;
		write_Data: in std_logic_vector(15 downto 0);
		target_Addr: in std_logic_vector(15 downto 0);

		RAddr: in std_logic_vector(15 downto 0);
		Ram2Data: inout std_logic_vector(15 downto 0);
		ToRam2_addr: out std_logic_vector(15 downto 0);

		Ram2EN: out std_logic;
		Ram2OE: out std_logic;
		Ram2WE: out std_logic
	);
end IF_manager;

architecture structural of IF_manager is
	COMPONENT adder
	PORT(
		old_pc : IN std_logic_vector(15 downto 0);          
		new_pc : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT Instruction_MEM
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		write_Enable : IN std_logic;
		write_Data : IN std_logic_vector(15 downto 0);
		target_Addr : IN std_logic_vector(15 downto 0);
		RAddr : IN std_logic_vector(15 downto 0);    
		data : INOUT std_logic_vector(15 downto 0);      
		Rdata : OUT std_logic_vector(15 downto 0);
		ToRam_addr : OUT std_logic_vector(15 downto 0);
		IRamEN : OUT std_logic;
		IRamOE : OUT std_logic;
		IRamWE : OUT std_logic
		);
	END COMPONENT;
begin

	Inst_adder: adder PORT MAP(
		old_pc => old_pc,
		new_pc => new_pc
	);

	Inst_Instruction_MEM: Instruction_MEM PORT MAP(
		clk => clk,
		rst => rst,
		write_Enable => write_Enable,
		write_Data => write_Data,
		target_Addr => target_Addr,
		RAddr => RAddr,
		Rdata => Instruction,
		data => Ram2Data,
		ToRam_addr => ToRam2_addr,
		IRamEN => Ram2EN,
		IRamOE => Ram2OE,
		IRamWE => Ram2WE
	);

end architecture ; -- structural