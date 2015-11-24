library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IF_manager is
	port (
		clk: in std_logic;
		rst: in std_logic;
		old_pc: in std_logic_vector(15 downto 0);
		new_pc: out std_logic_vector(15 downto 0);
		instruction: out std_logic_vector(15 downto 0);
		IM_OE_L: out std_logic;
		IM_WE_L: out std_logic
		);
end IF_manager;

architecture structural of IF_manager is
	COMPONENT adder
	PORT(
		old_pc : IN std_logic_vector(15 downto 0);          
		new_pc : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	COMPONENT ram
	PORT(
		clk: in std_logic;
		rst: in std_logic;
		data: inout std_logic_vector(15 downto 0);
		addr: in std_logic_vector(15 downto 0);
		read_enable: in std_logic;
		write_enable: in std_logic;
		OE_L: out std_logic;
		WE_L: out std_logic;
		ram_out: out std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	signal set_read_enable: std_logic := '1';
	signal set_write_unable: std_logic := '0';
begin
	Inst_adder: adder PORT MAP(
		old_pc => old_pc,
		new_pc => new_pc
	);
	Inst_ram: ram PORT MAP(
		clk => clk,
		rst => rst,
		data => "ZZZZZZZZZZZZZZZZ",
		addr => old_pc,
		read_enable => set_read_enable,
		write_enable => set_write_unable,
		OE_L => IM_OE_L,
		WE_L => IM_WE_L,
		ram_out => instruction
	);
end architecture ; -- structural