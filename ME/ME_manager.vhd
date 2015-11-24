library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ME_manager is
	port (
		clk: in std_logic;
		rst: in std_logic;
		--control_memToReg: in std_logic;
		--control_memRead: in std_logic;
		--control_memWrite: in std_logic;
		--control_regWrite_in: in std_logic_vector(2 downto 0);
		--ALUresult_in: in std_logic_vector(15 downto 0);
		ram_addr: in std_logic_vector(15 downto 0);
		--desReg_in: in std_logic_vector(2 downto 0);
		--desReg_out: out std_logic_vector(2 downto 0);
		result_out: out std_logic_vector(15 downto 0);
		--control_regWrite_out: out std_logic_vector(2 downto 0)
		C_14: out std_logic;
		OE_L: out std_logic;
		WE_L: out std_logic;
		ram_en: out std_logic
		);
end ME_manager;

architecture behavioral of ME_manager is

	component ram
		port (
			clk: in std_logic;
			rst: in std_logic;
			data: inout std_logic_vector(15 downto 0);
			read_enable: in std_logic;
			write_enable: in std_logic;
			OE_L: out std_logic;
			WE_L: out std_logic;
			ram_addr_out: out std_logic_vector(17 downto 0);
			ram_out: out std_logic_vector(15 downto 0)
		);		
	end component;

	component mux_wbData
		port (
			control_memToReg: in std_logic;
			ALUresult: in std_logic_vector(15 downto 0);
			ramResult: in std_logic_vector(15 downto 0);
			result: out std_logic_vector(15 downto 0)
		);
	end component;

	signal inout_signal: std_logic_vector(15 downto 0);
	signal ramResult: std_logic_vector(15 downto 0);

	signal control_memRead: std_logic := '1';
	signal control_memWrite: std_logic := '0';
	signal control_memToReg: std_logic := '1';
	signal ALUresult_in: std_logic_vector(15 downto 0) := "1111111111111111";
	signal tem_ram_addr: std_logic_vector(17 downto 0);
begin
	ram_en <= '0';
	tem_ram_addr(15 downto 0) <= ram_addr;
	tem_ram_addr(17 downto 16) <= "00";

	Inst_ram: ram PORT MAP(
		clk => clk,
		rst => rst,
		data => inout_signal,
		read_enable => control_memRead,
		write_enable => control_memWrite,
		OE_L => OE_L,
		WE_L => WE_L,
		ram_addr_out => tem_ram_addr,
		ram_out => ramResult
	);
	Inst_mux_wbData: mux_wbData PORT MAP(
		control_memToReg => control_memToReg,
		ALUresult => ALUresult_in,
		ramResult => ramResult,
		result => result_out
	);

	--desReg_out <= desReg_in;
	--control_regWrite_out <= control_regWrite_in;
	
	process(control_memWrite, inout_signal, ALUresult_in)
	begin
		if control_memWrite = '1' then
			inout_signal <= ALUresult_in;
		end if;
		C_14 <= '1';
	end process;
	
end architecture ; -- behavioral