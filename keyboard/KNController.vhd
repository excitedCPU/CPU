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
	
	Be_Pushed: out std_logic_vector(7 downto 0);	--The Key was being pushed;
	scancode_out: out std_logic_vector(7 downto 0);
	status: out std_logic
	--debug: out std_logic_vector(7 downto 0)
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
	
	signal scancode: std_logic_vector(7 downto 0); 
	signal enable: std_logic;
	
	type state is
		(None, E0, F0, E0F0); 
	shared variable s0: state := None; 
	shared variable tmp: state;
	signal clk2 : std_logic := '0';
begin
	KB:	keyboard port map (PS_data, PS_clk, sys_clk, not rst, enable, scancode);
	scancode_out <= scancode;
	
	process(sys_clk)
	begin
		if (sys_clk'event and sys_clk = '0') then
			clk2 <= not clk2;
		end if;
	end process;
	
	process(enable, sys_clk, rst)
	begin
		
		if (enable = '1' and rising_edge(sys_clk)) then

					status <= '0';
					case scancode is
						--when X"29" => tmp <= None;
						when X"45" => Be_Pushed <= ASCII_0;
						when X"16" => Be_Pushed <= ASCII_1;
						when X"1E" => Be_Pushed <= ASCII_2;
						when X"26" => Be_Pushed <= ASCII_3;
						when X"25" => Be_Pushed <= ASCII_4;
						when X"2E" => Be_Pushed <= ASCII_5;
						when X"36" => Be_Pushed <= ASCII_6;
						when X"3D" => Be_Pushed <= ASCII_7;
						when X"3E" => Be_Pushed <= ASCII_8;
						when X"46" => Be_Pushed <= ASCII_9;
						when X"1C" => Be_Pushed <= ASCII_A;
						when X"32" => Be_Pushed <= ASCII_B;
						when X"21" => Be_Pushed <= ASCII_C;
						when X"23" => Be_Pushed <= ASCII_D;
						when X"24" => Be_Pushed <= ASCII_E;
						when X"2B" => Be_Pushed <= ASCII_F;
						when X"34" => Be_Pushed <= ASCII_G;
						when X"33" => Be_Pushed <= ASCII_H;
						when X"43" => Be_Pushed <= ASCII_I;
						when X"3B" => Be_Pushed <= ASCII_J;
						when X"42" => Be_Pushed <= ASCII_K;
						when X"4B" => Be_Pushed <= ASCII_L;
						when X"3A" => Be_Pushed <= ASCII_M;
						when X"31" => Be_Pushed <= ASCII_N;
						when X"44" => Be_Pushed <= ASCII_O;
						when X"4D" => Be_Pushed <= ASCII_P;
						when X"15" => Be_Pushed <= ASCII_Q;
						when X"2D" => Be_Pushed <= ASCII_R;
						when X"1B" => Be_Pushed <= ASCII_S;
						when X"2C" => Be_Pushed <= ASCII_T;
						when X"3C" => Be_Pushed <= ASCII_U;
						when X"2A" => Be_Pushed <= ASCII_V;
						when X"1D" => Be_Pushed <= ASCII_W;
						when X"22" => Be_Pushed <= ASCII_X;
						when X"35" => Be_Pushed <= ASCII_Y;
						when X"1A" => Be_Pushed <= ASCII_Z;
						when others => Be_Pushed <= X"FF";
					end case;
					tmp := None;
			
		end if;
		
		if (rst = '0') then
			tmp := None;
			Be_Pushed <= X"FF";
		end if;
		
		s0 := tmp;
	end process;
end achieve;