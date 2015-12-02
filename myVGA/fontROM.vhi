
-- VHDL Instantiation Created from source file fontROM.vhd -- 00:58:22 12/02/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT fontROM
	PORT(
		row_addr : IN std_logic_vector(10 downto 0);
		col_addr : IN std_logic_vector(2 downto 0);          
		dataOut : OUT std_logic
		);
	END COMPONENT;

	Inst_fontROM: fontROM PORT MAP(
		row_addr => ,
		col_addr => ,
		dataOut => 
	);


