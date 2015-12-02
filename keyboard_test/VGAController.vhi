
-- VHDL Instantiation Created from source file VGAController.vhd -- 15:52:36 12/02/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT VGAController
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;          
		hs : OUT std_logic;
		vs : OUT std_logic;
		r : OUT std_logic_vector(2 downto 0);
		g : OUT std_logic_vector(2 downto 0);
		b : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	Inst_VGAController: VGAController PORT MAP(
		rst => ,
		clk => ,
		hs => ,
		vs => ,
		r => ,
		g => ,
		b => 
	);


