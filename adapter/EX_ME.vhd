library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_ME is
	port (
		clk, rst: in std_logic;
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
	process(clk, rst)
	begin
		if rst = '1' then
			control_memToReg_out <= '0';
			control_regWrite_out <= "000";
			control_memRead_out <= "000";
			control_memWrite_out <= "000";
			from_branch_control_out <= '0';
			desReg_out <= "0000000000000000";
			ram_addr_out <= "0000000000000000";
			ALUresult_out <= "0000000000000000";
		elsif clk'event and clk = '1' then
			control_memToReg_out <= control_memToReg_in;
			control_regWrite_out <= control_regWrite_in;
			control_memRead_out <= control_memRead_in;
			control_memWrite_out <= control_memWrite_in;
			from_branch_control_out <= from_branch_control_in;
			desReg_out <= desReg_in;
			ram_addr_out <= ram_addr_in;
			ALUresult_out <= ALUresult_in;
		end if;
	end process;

end architecture ; -- behavioral