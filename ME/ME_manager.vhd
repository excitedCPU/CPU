library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity ME_manager is
	port (
		control_memToReg: in std_logic;
		control_regWrite: in std_logic_vector(2 downto 0);
		control_memRead: in std_logic_vector(2 downto 0);
		control_memWrite: in std_logic_vector(2 downto 0);
		ALUresult: in std_logic_vector(15 downto 0);
		ram_addr_in: in std_logic_vector(15 downto 0);
		desReg_in: in std_logic_vector(15 downto 0);
		desReg_out: out std_logic_vector(15 downto 0);
		regWrite_out: out std_logic_vector(2 downto 0);
		data_result: out std_logic_vector(15 downto 0);
		ram_addr_out: out std_logic_vector(15 downto 0);
		);
end ME_manager;

architecture behavioral of ME_manager is

begin

end architecture ; -- behavioral