library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity commonRegister is
	port (
		read_rx: in std_logic_vector(2 downto 0);
		read_ry: in std_logic_vector(2 downto 0);
		from_ME_WB: in std_logic_vector(15 downto 0);
		write_addr: in std_logic_vector(2 downto 0);
		write_data: in std_logic_vector(15 downto 0);
		write_enable: in std_logic;
		read_result1: out std_logic_vector(15 downto 0);
		read_result2: out std_logic_vector(15 downto 0)
		);
end commonRegister;

architecture behavioral of commonRegister is

begin

end architecture ; -- behavioral