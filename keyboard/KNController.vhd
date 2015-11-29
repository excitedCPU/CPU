----------------------------------------Decode------------------------

LIBRARY ieee; 
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

entity KNController is
port 
(
	sys_clk: in std_logic;	--system clock;
	PS_data: in std_logic; 	--system Data;
	PS_clk: in std_logic;	--PS/2 clock;
	rst: in std_logic;		--reset;
	
	Be_Pushed: out std_logic_vector(7 downto 0)	--The Key was being pushed;
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
	--debug <= scancode;
	
	process(sys_clk)
	begin
		if (sys_clk'event and sys_clk = '0') then
			clk2 <= not clk2;
		end if;
	end process;
	
	process(enable, sys_clk, rst)
	begin
		
		if (enable = '1' and rising_edge(sys_clk)) then
			tmp := s0;
			
			case s0 is
				when None =>
					case scancode is
						when X"E0" => tmp := E0;
						when others => tmp := None;
					end case;
					
				when E0 => 
					case scancode is
						--when X"29" => tmp <= None;
						when X"45" => Be_Pushed <= X"00";
						when X"45" => Be_Pushed <= X"01";
						when X"45" => Be_Pushed <= X"02";
						when X"45" => Be_Pushed <= X"03";
						when X"45" => Be_Pushed <= X"04";
						when X"45" => Be_Pushed <= X"05";
						when X"45" => Be_Pushed <= X"06";
						when X"45" => Be_Pushed <= X"07";
						when X"45" => Be_Pushed <= X"08";
						when X"45" => Be_Pushed <= X"09";
						when others => Be_Pushed <= X"FF";
					end case;
					tmp := None
					
				when others => tmp := None;
			end case;
			
		end if;
		
		if (rst = '0') then
			tmp := None;
			Be_Pushed <= X"FF";
		end if;
		
		s0 := tmp;
	end process;
end achieve;