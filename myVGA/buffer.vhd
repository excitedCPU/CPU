library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use ascii_define.ALL;

entity my_buffer is
	port (
		-- clk
		clk: in std_logic;
		rst: in std_logic;
		
		isNewChar: in std_logic;						-- from ram
		input_ascii: in std_logic_vector(6 downto 0);	-- from ram
		bit_addr: in std_logic_vector(6 downto 0);		-- from VGA
		char_addr: in std_logic_vector(11 downto 0);	-- from VGA

		
		can_write: out std_logic; 								-- to ram
		ascii_with_bit_addr: out std_logic_vector(10 downto 0); 	-- to VGA
		bit_addr_last_three: out std_logic_vector(2 downto 0);
		not_exceed_max_col: out std_logic
		);
end my_buffer;

architecture behavioral of my_buffer is

	COMPONENT new_buffer_ram
	  PORT (
	    clka : IN STD_LOGIC;
	    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	    addra : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	    dina : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
	    clkb : IN STD_LOGIC;
	    addrb : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
	    doutb : OUT STD_LOGIC_VECTOR(255 DOWNTO 0)
	  );
	END COMPONENT;

	signal write_row: integer := 0;
	signal write_col: integer := 0;
	signal read_row: integer := 0;
	signal read_col: integer := 0;
	signal physical_row: integer := 0;
	signal physical_col: integer := 0;
	signal MAX_COL: integer := 32;
	signal MAX_ROW: integer := 32;

	signal ram_en: STD_LOGIC_VECTOR(0 DOWNTO 0) := "1";
	signal addra: std_logic_vector(4 downto 0) := "00000";
	signal addrb: std_logic_vector(4 downto 0) := "00000";
	signal dina: std_logic_vector(255 downto 0);
	signal doutb: std_logic_vector(255 downto 0);
	signal ascii_to_vga: std_logic_vector(6 downto 0) := "1000000";
begin

	my_buffer_ram : new_buffer_ram
	  PORT MAP (
	    clka => clk,	
	    wea => ram_en,	-- enable
	    addra => addra,	-- write addr
	    dina => dina,	-- write data
	    clkb => clk,
	    addrb => addrb,	-- read addr
	    doutb => doutb	-- read data
	  );
	
	ram_write_process: process(clk, isNewChar)
	begin
		if clk'event and clk = '0' then
			-- write process
			if isNewChar = '1' then
				write_col <= write_col + 1;
				if write_col >= MAX_COL then
					write_row <= write_row + 1;
					write_col <= 0;
				end if;
				addra <= conv_std_logic_vector(31 - write_row, 5);
				dina((255 - write_col*7) downto (255 - write_col*7 - 6)) <= input_ascii;
			end if;
			-- read process
			read_row <= conv_integer(char_addr(11 downto 7));
			read_col <= conv_integer(char_addr(6 downto 0));
			if read_col > MAX_COL then
				not_exceed_max_col <= '0';
				ascii_to_vga <= ASCII_SPACE(6 downto 0);
			elsif read_col <= MAX_COL then
				not_exceed_max_col <= '1';
				addrb <= conv_std_logic_vector(31 - read_row, 5);
				ascii_to_vga <= doutb((255 - read_col*7) downto (255 - read_col*7 - 6));
			end if;
		end if;
	end process;

	ascii_with_bit_addr(3 downto 0) <= bit_addr(6 downto 3);
	ascii_with_bit_addr(10 downto 4) <= ascii_to_vga;
	bit_addr_last_three <= bit_addr(2 downto 0);
end architecture ; -- behavioral



