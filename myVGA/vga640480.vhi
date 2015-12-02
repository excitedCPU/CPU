
-- VHDL Instantiation Created from source file vga640480.vhd -- 00:58:46 12/02/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT vga640480
	PORT(
		reset : IN std_logic;
		q : IN std_logic;
		clk_0 : IN std_logic;          
		bit_addr : OUT std_logic_vector(6 downto 0);
		char_addr : OUT std_logic_vector(11 downto 0);
		clk25 : OUT std_logic;
		hs : OUT std_logic;
		vs : OUT std_logic;
		r : OUT std_logic_vector(2 downto 0);
		g : OUT std_logic_vector(2 downto 0);
		b : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	Inst_vga640480: vga640480 PORT MAP(
		bit_addr => ,
		char_addr => ,
		reset => ,
		clk25 => ,
		q => ,
		clk_0 => ,
		hs => ,
		vs => ,
		r => ,
		g => ,
		b => 
	);


