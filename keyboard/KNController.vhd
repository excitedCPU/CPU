----------------------------------------Decode------------------------

LIBRARY ieee; 
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
USE ascii_define.all;

entity KNController is
port 
(
	sys_clk: in std_logic;	--system clock;
	PS_data: in std_logic; 	--system Data;
	PS_clk: in std_logic;	--PS/2 clock;
	rst: in std_logic;		--reset;
	
	scancode_out: out std_logic_vector(7 downto 0);
	status: out std_logic;
	
	-- to ram
	is_ready: out std_logic;
	Be_Pushed: out std_logic_vector(7 downto 0);	--The Key being pushed;
	
	
	hs : OUT std_logic;
	vs : OUT std_logic;
	r : OUT std_logic_vector(2 downto 0);
	g : OUT std_logic_vector(2 downto 0);
	b : OUT std_logic_vector(2 downto 0)
);
end KNController;

architecture achieve of KNController is
	component keyboard is
	port
	(
		datain, clkin : in std_logic ; 	-- PS2 clk and data
		fclk, rst : in std_logic ;  	-- filter clock
		isfok : out std_logic ;  		-- data output enable signal
		scancode : out std_logic_vector(7 downto 0) 	-- scan code signal output	
	);
	end component;
	
	
	COMPONENT VGAController
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;     
		isNewChar: IN std_logic;
		input_ascii: IN std_logic_vector(6 downto 0);     
		hs : OUT std_logic;
		vs : OUT std_logic;
		r : OUT std_logic_vector(2 downto 0);
		g : OUT std_logic_vector(2 downto 0);
		b : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
	-- keyboard tem_signal
	signal scancode: std_logic_vector(7 downto 0); 
	signal enable: std_logic;
	signal is_valid_char: std_logic := '0';
	signal is_being_pressed: std_logic := '0';
	signal tem_is_ready: std_logic := '0';
	signal tem_ascii: std_logic_vector(7 downto 0);
	
	type state is
		(None, E0, F0, E0F0); 
	shared variable s0: state := None; 
	shared variable tmp: state;
begin
	KB:	keyboard port map (PS_data, PS_clk, sys_clk, not rst, enable, scancode);
	
	
	Inst_VGAController: VGAController PORT MAP(
		rst => rst,
		clk => sys_clk,
		isNewChar => tem_is_ready,
		input_ascii => tem_ascii(6 downto 0),
		hs => hs,
		vs => vs,
		r => r,
		g => g,
		b => b
	);
	scancode_out <= scancode;
	is_ready <= enable and is_being_pressed;
	tem_is_ready <= enable and is_being_pressed;
	Be_Pushed <= tem_ascii;
	process(enable, sys_clk, rst)
	begin
		
		if (enable = '1' and falling_edge(sys_clk)) then
			is_valid_char <= '1';
			is_being_pressed <= not is_being_pressed;
			case scancode is
				--when X"29" => tmp <= None;
				when X"45" => tem_ascii <= ASCII_0;
				when X"16" => tem_ascii <= ASCII_1;
				when X"1E" => tem_ascii <= ASCII_2;
				when X"26" => tem_ascii <= ASCII_3;
				when X"25" => tem_ascii <= ASCII_4;
				when X"2E" => tem_ascii <= ASCII_5;
				when X"36" => tem_ascii <= ASCII_6;
				when X"3D" => tem_ascii <= ASCII_7;
				when X"3E" => tem_ascii <= ASCII_8;
				when X"46" => tem_ascii <= ASCII_9;
				when X"1C" => tem_ascii <= ASCII_A;
				when X"32" => tem_ascii <= ASCII_B;
				when X"21" => tem_ascii <= ASCII_C;
				when X"23" => tem_ascii <= ASCII_D;
				when X"24" => tem_ascii <= ASCII_E;
				when X"2B" => tem_ascii <= ASCII_F;
				when X"34" => tem_ascii <= ASCII_G;
				when X"33" => tem_ascii <= ASCII_H;
				when X"43" => tem_ascii <= ASCII_I;
				when X"3B" => tem_ascii <= ASCII_J;
				when X"42" => tem_ascii <= ASCII_K;
				when X"4B" => tem_ascii <= ASCII_L;
				when X"3A" => tem_ascii <= ASCII_M;
				when X"31" => tem_ascii <= ASCII_N;
				when X"44" => tem_ascii <= ASCII_O;
				when X"4D" => tem_ascii <= ASCII_P;
				when X"15" => tem_ascii <= ASCII_Q;
				when X"2D" => tem_ascii <= ASCII_R;
				when X"1B" => tem_ascii <= ASCII_S;
				when X"2C" => tem_ascii <= ASCII_T;
				when X"3C" => tem_ascii <= ASCII_U;
				when X"2A" => tem_ascii <= ASCII_V;
				when X"1D" => tem_ascii <= ASCII_W;
				when X"22" => tem_ascii <= ASCII_X;
				when X"35" => tem_ascii <= ASCII_Y;
				when X"1A" => tem_ascii <= ASCII_Z;
				when X"5A" => tem_ascii <= ASCII_ENTER;
				when X"29" => tem_ascii <= ASCII_SPACE;
				when X"66" => tem_ascii <= ASCII_BACK;
				when X"F0" =>
					tem_ascii <= ASCII_bg; 
					is_valid_char <= '0';
					is_being_pressed <= '0';
				when others => 
					tem_ascii <= ASCII_bx;
			end case;
			tmp := None;
			
		end if;
		
		if (rst = '0') then
			tmp := None;
			tem_ascii <= ASCII_SPACE;
		end if;
		
		s0 := tmp;
	end process;
end achieve;