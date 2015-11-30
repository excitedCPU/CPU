library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ME_manager is
	port (
		clk: in std_logic;
		rst: in std_logic;

		control_memToReg_in: in std_logic;
		control_regWrite_in: in std_logic_vector(2 downto 0);
		control_memWrite_in: in std_logic;
		control_memRead_in: in std_logic;

		control_regWrite_out: out std_logic_vector(2 downto 0);

		ALUresult: in std_logic_vector(15 downto 0);
		store_data: in std_logic_vector(15 downto 0);

		result_out: out std_logic_vector(15 downto 0);

		Ram1EN: out std_logic;
		Ram1OE: out std_logic;
		Ram1WE: out std_logic;

		ToRam1_addr: out std_logic_vector(15 downto 0);
		data: inout std_logic_vector(15 downto 0);

		wrn: out std_logic;
		rdn: out std_logic;
		data_ready: in std_logic;
		tbre: in std_logic;
		tsre: in std_logic;
		
		Rtarget_in: in std_logic_vector(2 downto 0);
		Rtarget_out: out std_logic_vector(2 downto 0);
		
		Ram2ReadEnable: out std_logic;
		Ram2WriteEnable: out std_logic;
		Ram2Data: out std_logic_vector(15 downto 0);
		Ram2Addr: out std_logic_vector(15 downto 0);
		
		From_Ram2Data: in std_logic_vector(15 downto 0)
	);
end ME_manager;

architecture behavioral of ME_manager is

	COMPONENT ram
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		memWrite : IN std_logic;
		memRead : IN std_logic;
		write_data : IN std_logic_vector(15 downto 0);
		target_addr : IN std_logic_vector(15 downto 0);
		data_ready : IN std_logic;
		tbre : IN std_logic;
		tsre : IN std_logic;
		From_Ram2Data : IN std_logic_vector(15 downto 0);    
		data : INOUT std_logic_vector(15 downto 0);      
		Rdata : OUT std_logic_vector(15 downto 0);
		Ram1EN : OUT std_logic;
		Ram1WE : OUT std_logic;
		Ram1OE : OUT std_logic;
		ToRam_addr : OUT std_logic_vector(15 downto 0);
		wrn : OUT std_logic;
		rdn : OUT std_logic;
		Ram2ReadEnable : OUT std_logic;
		Ram2WriteEnable : OUT std_logic;
		Ram2Data : OUT std_logic_vector(15 downto 0);
		Ram2Addr : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	component mux_wbData
		port (
			control_memToReg: in std_logic;
			ALUresult: in std_logic_vector(15 downto 0);
			ramResult: in std_logic_vector(15 downto 0);
			result: out std_logic_vector(15 downto 0)
		);
	end component;

	signal ram_out: std_logic_vector(15 downto 0); 
begin
	control_regWrite_out <= control_regWrite_in;
	Rtarget_out <= Rtarget_in;

	Inst_ram: ram PORT MAP(
		clk => clk,
		rst => rst,
		memWrite => control_memWrite_in,
		memRead => control_memRead_in,
		write_data => store_data,
		target_addr => ALUresult,
		Rdata => ram_out,
		Ram1EN => Ram1EN,
		Ram1WE => Ram1WE,
		Ram1OE => Ram1OE,
		data => data,
		ToRam_addr => ToRam1_addr,
		wrn => wrn,
		rdn => rdn,
		data_ready => data_ready,
		tbre => tbre,
		tsre => tsre,
		
		Ram2ReadEnable => Ram2ReadEnable,
		Ram2WriteEnable => Ram2WriteEnable,
		Ram2Data => Ram2Data,
		Ram2Addr => Ram2Addr,
		From_Ram2Data => From_Ram2Data
	);

	Inst_mux_wbData: mux_wbData PORT MAP(
		control_memToReg => control_memToReg_in,
		ALUresult => ALUresult,
		ramResult => ram_out,
		result => result_out
	);

	
end architecture ; -- behavioral