library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_ME is
	port (
		control_memToReg_in: in std_logic;
		control_regWrite_in: in std_logic_vector(2 downto 0);
		control_memRead_in: in std_logic_vector(2 downto 0);
		control_memWrite_in: in std_logic_vector(2 downto 0);
		from_branch_control_in: in std_logic;
		desReg_in: in std_logic_vector(15 downto 0);
		ram_addr_in: in std_logic_vector(15 downto 0);
		ALUresult_in: in std_logic_vector(15 downto 0);

		control_memToReg_out: out std_logic;
		control_regWrite_out: out std_logic_vector(2 downto 0);
		control_memRead_out: out std_logic_vector(2 downto 0);
		control_memWrite_out: out std_logic_vector(2 downto 0);
		from_branch_control_out: out std_logic;
		desReg_out: out std_logic_vector(15 downto 0);
		ram_addr_out: out std_logic_vector(15 downto 0);
		ALUresult_out: out std_logic_vector(15 downto 0)
		);
end EX_ME;

architecture behavioral of EX_ME is
begin

end architecture ; -- behavioral