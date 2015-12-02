library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package ascii_define is

	constant ASCII_ENTER: std_logic_vector(7 downto 0) := x"00";
	constant ASCII_SPACE: std_logic_vector(7 downto 0) := x"20";
	constant ASCII_BACK: std_logic_vector(7 downto 0) := x"08";

	constant ASCII_0: std_logic_vector(7 downto 0) := x"30";
	constant ASCII_1: std_logic_vector(7 downto 0) := x"31";
	constant ASCII_2: std_logic_vector(7 downto 0) := x"32";
	constant ASCII_3: std_logic_vector(7 downto 0) := x"33";
	constant ASCII_4: std_logic_vector(7 downto 0) := x"34";
	constant ASCII_5: std_logic_vector(7 downto 0) := x"35";
	constant ASCII_6: std_logic_vector(7 downto 0) := x"36";
	constant ASCII_7: std_logic_vector(7 downto 0) := x"37";
	constant ASCII_8: std_logic_vector(7 downto 0) := x"38";
	constant ASCII_9: std_logic_vector(7 downto 0) := x"39";

	constant ASCII_A: std_logic_vector(7 downto 0) := x"41";
	constant ASCII_B: std_logic_vector(7 downto 0) := x"42";
	constant ASCII_C: std_logic_vector(7 downto 0) := x"43";
	constant ASCII_D: std_logic_vector(7 downto 0) := x"44";
	constant ASCII_E: std_logic_vector(7 downto 0) := x"45";
	constant ASCII_F: std_logic_vector(7 downto 0) := x"46";
	constant ASCII_G: std_logic_vector(7 downto 0) := x"47";
	constant ASCII_H: std_logic_vector(7 downto 0) := x"48";
	constant ASCII_I: std_logic_vector(7 downto 0) := x"49";
	constant ASCII_J: std_logic_vector(7 downto 0) := x"4A";
	constant ASCII_K: std_logic_vector(7 downto 0) := x"4B";
	constant ASCII_L: std_logic_vector(7 downto 0) := x"4C";
	constant ASCII_M: std_logic_vector(7 downto 0) := x"4D";
	constant ASCII_N: std_logic_vector(7 downto 0) := x"4E";
	constant ASCII_O: std_logic_vector(7 downto 0) := x"4F";
	constant ASCII_P: std_logic_vector(7 downto 0) := x"50";
	constant ASCII_Q: std_logic_vector(7 downto 0) := x"51";
	constant ASCII_R: std_logic_vector(7 downto 0) := x"52";
	constant ASCII_S: std_logic_vector(7 downto 0) := x"53";
	constant ASCII_T: std_logic_vector(7 downto 0) := x"54";
	constant ASCII_U: std_logic_vector(7 downto 0) := x"55";
	constant ASCII_V: std_logic_vector(7 downto 0) := x"56";
	constant ASCII_W: std_logic_vector(7 downto 0) := x"57";
	constant ASCII_X: std_logic_vector(7 downto 0) := x"58";
	constant ASCII_Y: std_logic_vector(7 downto 0) := x"59";
	constant ASCII_Z: std_logic_vector(7 downto 0) := x"5A";

	constant ASCII_ba: std_logic_vector(7 downto 0) := x"61";
	constant ASCII_bb: std_logic_vector(7 downto 0) := x"62";
	constant ASCII_bc: std_logic_vector(7 downto 0) := x"63";
	constant ASCII_bd: std_logic_vector(7 downto 0) := x"64";
	constant ASCII_be: std_logic_vector(7 downto 0) := x"65";
	constant ASCII_bf: std_logic_vector(7 downto 0) := x"66";
	constant ASCII_bg: std_logic_vector(7 downto 0) := x"67";
	constant ASCII_bh: std_logic_vector(7 downto 0) := x"68";
	constant ASCII_bi: std_logic_vector(7 downto 0) := x"69";
	constant ASCII_bj: std_logic_vector(7 downto 0) := x"6A";
	constant ASCII_bk: std_logic_vector(7 downto 0) := x"6B";
	constant ASCII_bl: std_logic_vector(7 downto 0) := x"6C";
	constant ASCII_bm: std_logic_vector(7 downto 0) := x"6D";
	constant ASCII_bn: std_logic_vector(7 downto 0) := x"6E";
	constant ASCII_bo: std_logic_vector(7 downto 0) := x"6F";
	constant ASCII_bp: std_logic_vector(7 downto 0) := x"70";
	constant ASCII_bq: std_logic_vector(7 downto 0) := x"71";
	constant ASCII_br: std_logic_vector(7 downto 0) := x"72";
	constant ASCII_bs: std_logic_vector(7 downto 0) := x"73";
	constant ASCII_bt: std_logic_vector(7 downto 0) := x"74";
	constant ASCII_bu: std_logic_vector(7 downto 0) := x"75";
	constant ASCII_bv: std_logic_vector(7 downto 0) := x"76";
	constant ASCII_bw: std_logic_vector(7 downto 0) := x"77";
	constant ASCII_bx: std_logic_vector(7 downto 0) := x"78";
	constant ASCII_by: std_logic_vector(7 downto 0) := x"79";
	constant ASCII_bz: std_logic_vector(7 downto 0) := x"7A";
	
	constant ASCII_row_start: std_logic_vector(20 downto 0) := "011111001111100111110";

end ascii_define;

