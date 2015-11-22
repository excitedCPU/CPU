library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity ram is
	port (
		data: in std_logic_vector(15 downto 0);
		addr: in std_logic_vector(15 downto 0);
		read_enable: in std_logic;
		write_enable: in std_logic;
		read_result: out std_logic_vector(15 downto 0);
		);
end ram;

architecture behavioral of ram is

begin

end architecture ; -- behavioral