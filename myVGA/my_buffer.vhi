
-- VHDL Instantiation Created from source file my_buffer.vhd -- 01:00:12 12/02/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT my_buffer
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		isNewChar : IN std_logic;
		input_ascii : IN std_logic_vector(6 downto 0);
		bit_addr : IN std_logic_vector(6 downto 0);
		char_addr : IN std_logic_vector(11 downto 0);          
		can_write : OUT std_logic;
		ascii_with_bit_addr : OUT std_logic_vector(10 downto 0);
		bit_addr_last_three : OUT std_logic_vector(2 downto 0);
		not_exceed_max_col : OUT std_logic
		);
	END COMPONENT;

	Inst_my_buffer: my_buffer PORT MAP(
		clk => ,
		rst => ,
		isNewChar => ,
		input_ascii => ,
		bit_addr => ,
		char_addr => ,
		can_write => ,
		ascii_with_bit_addr => ,
		bit_addr_last_three => ,
		not_exceed_max_col => 
	);


