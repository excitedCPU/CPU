library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity commonRegister is
	port (
		rst: in std_logic;
		read_rx: in std_logic_vector(2 downto 0);
		read_ry: in std_logic_vector(2 downto 0);
		write_addr: in std_logic_vector(2 downto 0);
		write_data: in std_logic_vector(15 downto 0);
		regWrite: in std_logic_vector(2 downto 0);
		read_result1: out std_logic_vector(15 downto 0);
		read_result2: out std_logic_vector(15 downto 0)
		);
end commonRegister;

architecture behavioral of commonRegister is
	type registerFile is array(0 to 7) of std_logic_vector(15 downto 0);
	signal registers : registerFile;
begin
	readRegister: process(read_rx, read_ry, registers)
	begin
		read_result1 <= registers(to_integer(unsigned(read_rx)));
		read_result2 <= registers(to_integer(unsigned(read_ry)));
	end process;
	
	writeRegister: process(write_addr, write_data, regWrite, rst)
	begin
		if (rst = '0') then
			registers(0) <= "0000000000000000";
			registers(1) <= "0000000000000000";
			registers(2) <= "0000000000000000";
			registers(3) <= "0000000000000000";
			registers(4) <= "0000000000000000";
			registers(5) <= "0000000000000000";
			registers(6) <= "0000000000000000";
			registers(7) <= "0000000000000000";			
		elsif regWrite = "000" then
			registers(to_integer(unsigned(write_addr))) <= write_data;
		end if;
	end process;

end architecture ; -- behavioral