----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:06:44 11/30/2015 
-- Design Name: 
-- Module Name:    Flash_controler - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Flash_controler is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
		   FlashByte: out std_logic;
		   FlashVpen: out std_logic;
		   FlashCE: out std_logic;
		   FlashOE: out std_logic;
		   FlashWE: out std_logic;
		   FlashRP: out std_logic;
		   FlashAddr: out std_logic_vector(22 downto 0);
		   FlashData: inout std_logic_vector(15 downto 0);
		   
		   display: out std_logic_vector(15 downto 0);
		   
		   flash_ready: out std_logic;
		   FlashRam2EN : out std_logic;
		   FlashRam2OE : out std_logic;
		   FlashRam2WE : out std_logic := '0';
		   FlashRam2Addr : out std_logic_vector(15 downto 0);
		   FlashRam2Data : out std_logic_vector(15 downto 0)
	);
end Flash_controler;

architecture Behavioral of Flash_controler is
	signal boot_addr: std_logic_vector(15 downto 0) := "0000000000000000";
	signal flash_over : std_logic := '0';
	shared variable state : integer range 0 to 7 := 0;
begin
	
	flash_ready <= flash_over;
	FlashRam2Data <= FlashData;
	FlashRam2Addr <= boot_addr;
	
	logic_control: process(clk, rst)
	begin
		FlashAddr(22 downto 17) <= (others => '0');
		FlashAddr(0) <='0';
		FlashByte <= '1';
		FlashVpen <= '1';
		FlashRP <= '1';
		FlashCE <= '0';
		FlashWE <= '1';
		FlashRam2EN <= '0';
		FlashRam2OE <= '1';
		--FlashRam2WE <= '0';
		display <= x"FFF0";
		if rst = '0' then
			boot_addr <= "0000000000000000";
			flash_over <= '0';
			state := 0;
		elsif clk'event and clk = '0' then
			case state is
				when 0 =>
					FlashOE <= '0';
					FlashRam2WE <= '1';
					FlashAddr(16 downto 1) <= boot_addr;
					FlashData <= "ZZZZZZZZZZZZZZZZ";
					
				when 1 =>
					FlashOE <= '1';
					FlashRam2WE <= '0';
					
				when 2 => NULL;
					--FlashRam2WE <= '0';
					
				when 3 =>
					--FlashRam2WE <= '1';
					boot_addr <= boot_addr + '1';
					
				when others => null;
			end case;
			if state = 3 then
				state := 0;
			else
				state := state + 1;
			end if;
		end if;
		if boot_addr > x"0011" then
			flash_over <= '1';
		end if;
	end process;
end Behavioral;