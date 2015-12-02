----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:46:22 12/01/2015 
-- Design Name: 
-- Module Name:    ram2_mux - Behavioral 
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

entity ram2_mux is
	PORT(
		flash_ready : in std_logic;
		cpu_ram2EN: in std_logic;
		cpu_ram2OE: in std_logic;
		cpu_ram2WE: in std_logic;
		cpu_ram2Addr: in std_logic_vector(15 downto 0);
		cpu_ram2Data: in std_logic_vector(15 downto 0);
		flash_ram2EN: in std_logic;
		flash_ram2OE: in std_logic;
		flash_ram2WE: in std_logic;
		flash_ram2Addr: in std_logic_vector(15 downto 0);
		flash_ram2Data: in std_logic_vector(15 downto 0);
		ram2EN: out std_logic;
		ram2OE: out std_logic;
		ram2WE: out std_logic;
		ram2Addr: out std_logic_vector(15 downto 0);
		ram2Data: out std_logic_vector(15 downto 0)
		);
end ram2_mux;

architecture Behavioral of ram2_mux is

begin
	ram2EN <= cpu_ram2EN when flash_ready = '1' else
			  flash_ram2EN;
	ram2OE <= cpu_ram2OE when flash_ready = '1' else
			  flash_ram2OE;
	ram2WE <= cpu_ram2WE when flash_ready = '1' else
			  flash_ram2WE;
	ram2Addr <= cpu_ram2Addr when flash_ready = '1' else
				flash_ram2Addr;
	ram2Data <= cpu_ram2Data when flash_ready = '1' else
				flash_ram2Data;
end Behavioral;

