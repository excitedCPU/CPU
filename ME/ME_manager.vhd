library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ME_manager is
	port (
		clk: in std_logic;
		rst: in std_logic;
		control_memToReg: in std_logic;
		control_memRead: in std_logic;
		control_memWrite: in std_logic;
		control_regWrite_in: in std_logic_vector(2 downto 0);
		ALUresult: in std_logic_vector(15 downto 0);
		ram_addr: in std_logic_vector(15 downto 0);
		desReg_in: in std_logic_vector(15 downto 0);
		desReg_out: out std_logic_vector(15 downto 0);
		ram_result: out std_logic_vector(15 downto 0);
		control_regWrite_out: out std_logic_vector(2 downto 0)
		);
end ME_manager;

architecture behavioral of ME_manager is

	component ram
		port (
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
	end component;
	signal OE_L, WE_L: std_logic;
	signal inout_signal: std_logic_vector(15 downto 0);
begin
	myRam: ram PORT MAP (clk, rst, inout_signal, ram_addr, control_memRead, control_memWrite, OE_L, WE_L, ram_result);

	desReg_out <= desReg_in;
	control_regWrite_out <= control_regWrite_in;
	
	process(control_memWrite)
	begin
		if control_memWrite = '1' then
			inout_signal <= ALUresult;
		end if;
	end process;
	
end architecture ; -- behavioral