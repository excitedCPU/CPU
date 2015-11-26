library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EX_ME is
	port (
		clk, rst: in std_logic;
		control_memToReg_in: in std_logic;
		control_regWrite_in: in std_logic_vector(2 downto 0);
		control_memRead_in: in std_logic;
		control_memWrite_in: in std_logic;
		from_branch_control_in: in std_logic;
		
		store_data: in std_logic_vector(15 downto 0);
		target_Addr: in std_logic_vector(2 downto 0);
		ALUresult_in: in std_logic_vector(15 downto 0);

		control_memToReg_out: out std_logic;
		control_regWrite_out: out std_logic_vector(2 downto 0);
		control_memRead_out: out std_logic;
		control_memWrite_out: out std_logic;
		from_branch_control_out: out std_logic;
		
		store_data_out: out std_logic_vector(15 downto 0);
		target_Addr_out: out std_logic_vector(2 downto 0);
		ALUresult_out: out std_logic_vector(15 downto 0)
		);
end EX_ME;

architecture behavioral of EX_ME is
begin
	process(clk, rst)
	begin
		if rst = '1' then
			control_memToReg_out <= '0';
			control_regWrite_out <= "100";
			control_memRead_out <= '0';
			control_memWrite_out <= '0';
			from_branch_control_out <= '0';
			store_data_out <= "0000000000000000";
			target_Addr_out <= "000";
			ALUresult_out <= "0000000000000000";
		elsif clk'event and clk = '0' then
			control_memToReg_out <= control_memToReg_in;
			control_regWrite_out <= control_regWrite_in;
			control_memRead_out <= control_memRead_in;
			control_memWrite_out <= control_memWrite_in;
			from_branch_control_out <= from_branch_control_in;
			store_data_out <= store_data;
			target_Addr_out <= target_Addr;
			ALUresult_out <= ALUresult_in;
		end if;
	end process;

end architecture ; -- behavioral