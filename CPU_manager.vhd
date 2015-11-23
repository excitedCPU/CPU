----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:08:35 11/23/2015 
-- Design Name: 
-- Module Name:    CPU_manager - Behavioral 
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
use C_SIGNAL.TEST_SIGNAL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU_manager is
	port (
		clk: in std_logic;
		rst: in std_logic;
		test_out: out std_logic_vector(2 downto 0)
	);
end CPU_manager;

architecture Behavioral of CPU_manager is
	
begin
	test_out <= TEST_SIGNAL;

end Behavioral;

