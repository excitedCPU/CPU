----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:57:37 12/02/2015 
-- Design Name: 
-- Module Name:    VGAController - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGAController is
	PORT
	(
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
end VGAController;

architecture Behavioral of VGAController is
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
	COMPONENT fontROM
	PORT(
		clk: 	in std_logic;
		row_addr : IN std_logic_vector(10 downto 0);
		col_addr : IN std_logic_vector(2 downto 0);          
		dataOut : OUT std_logic
		);
	END COMPONENT;
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
	signal q_in: std_logic:='0';
	signal clk25: std_logic:='1';
	signal to_buffer_char_addr: std_logic_vector(11 downto 0);
	signal to_buffer_bit_addr: std_logic_vector(6 downto 0);
	signal not_exceed: std_logic;
	signal to_rom_row: std_logic_vector(10 downto 0);
	signal to_rom_col: std_logic_vector(2 downto 0);
	signal temp: std_logic;
begin
	Inst_vga640480: vga640480 PORT MAP(
		bit_addr => to_buffer_bit_addr,
		char_addr => to_buffer_char_addr,
		reset => rst,
		clk25 => clk25,
		q => q_in,
		clk_0 => clk,
		hs => hs,
		vs => vs,
		r => r,
		g => g,
		b => b
	);
	Inst_fontROM: fontROM PORT MAP(
		clk => clk,
		row_addr => to_rom_row,
		col_addr => to_rom_col,
		dataOut => q_in
	);
	Inst_my_buffer: my_buffer PORT MAP(
		clk => clk,
		rst => rst,
		isNewChar => isNewChar,
		input_ascii => input_ascii,
		bit_addr => to_buffer_bit_addr,
		char_addr => to_buffer_char_addr,
		can_write => temp,
		ascii_with_bit_addr => to_rom_row,
		bit_addr_last_three => to_rom_col,
		not_exceed_max_col => not_exceed
	);
end Behavioral;

