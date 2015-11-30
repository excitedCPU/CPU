library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--4.283ns
entity ID_EX is
	port (
		clk, rst: in std_logic;
		To_Keep: in std_logic;
		control_branchOrJump_in: in std_logic_vector(2 downto 0);
		control_desRegister_in: in std_logic_vector(1 downto 0);
		control_ALUsrc1_in: in std_logic_vector(2 downto 0);
		control_ALUsrc2_in: in std_logic_vector(2 downto 0);
		control_ALUop_in: in std_logic_vector(3 downto 0);
		control_memToReg_in: in std_logic;
		control_regWrite_in: in std_logic_vector(2 downto 0);
		control_memWrite_in: in std_logic;
		control_memRead_in: in std_logic;
		control_WE_in: in std_logic;
		control_TE_in: in std_logic;
		updated_pc_in: in std_logic_vector(15 downto 0);
		from_register1_in: in std_logic_vector(15 downto 0);
		from_register2_in: in std_logic_vector(15 downto 0);
		from_IH_in: in std_logic_vector(15 downto 0);
		from_SP_in: in std_logic_vector(15 downto 0);
		from_imm_exp_in: in std_logic_vector(15 downto 0);
		from_T_in: in std_logic_vector(15 downto 0);
		from_instruction_7_5_in: in std_logic_vector(2 downto 0);
		from_instruction_4_2_in: in std_logic_vector(2 downto 0);
		from_instruction_10_8_in: in std_logic_vector(2 downto 0);

		control_branchOrJump_out: out std_logic_vector(2 downto 0);
		control_desRegister_out: out std_logic_vector(1 downto 0);
		control_ALUsrc1_out: out std_logic_vector(2 downto 0);
		control_ALUsrc2_out: out std_logic_vector(2 downto 0);
		control_ALUop_out: out std_logic_vector(3 downto 0);
		control_memToReg_out: out std_logic;
		control_regWrite_out: out std_logic_vector(2 downto 0);
		control_memWrite_out: out std_logic;
		control_memRead_out: out std_logic;
		control_WE_out: out std_logic;
		control_TE_out: out std_logic;
		updated_pc_out: out std_logic_vector(15 downto 0);
		from_register1_out: out std_logic_vector(15 downto 0);
		from_register2_out: out std_logic_vector(15 downto 0);
		from_IH_out: out std_logic_vector(15 downto 0);
		from_SP_out: out std_logic_vector(15 downto 0);
		from_imm_exp_out: out std_logic_vector(15 downto 0);
		from_T_out: out std_logic_vector(15 downto 0);
		from_instruction_7_5_out: out std_logic_vector(2 downto 0);
		from_instruction_4_2_out: out std_logic_vector(2 downto 0);
		from_instruction_10_8_out: out std_logic_vector(2 downto 0)
		);
end ID_EX;

architecture behavioral of ID_EX is
begin

	process(clk, rst)
	begin
		if rst = '0' then
			--all out signal set to zero
			control_branchOrJump_out <= "000";
			control_desRegister_out <= "00";
			control_ALUsrc1_out <= "111";
			control_ALUsrc2_out <= "111";
			control_ALUop_out <= "0000";
			control_memToReg_out <= '0';
			control_regWrite_out <= "100";
			control_memWrite_out <= '0';
			control_memRead_out <= '0';
			control_WE_out <= '0';
			control_TE_out <= '0';
			updated_pc_out <= "0000000000000000";
			from_register1_out <= "0000000000000000";
			from_register2_out <= "0000000000000000";
			from_IH_out <= "0000000000000000";
			from_SP_out <= "0000000000000000";
			from_imm_exp_out <= "0000000000000000";
			from_T_out <= "0000000000000000";
			from_instruction_7_5_out <= "000";
			from_instruction_4_2_out <= "000";
			from_instruction_10_8_out <= "000";
			
		elsif clk'event and clk = '0'  and To_Keep = '0' then
			control_branchOrJump_out <= control_branchOrJump_in;
			control_desRegister_out <= control_desRegister_in;
			control_ALUsrc1_out <= control_ALUsrc1_in;
			control_ALUsrc2_out <= control_ALUsrc2_in;
			control_ALUop_out <= control_ALUop_in;
			control_memToReg_out <= control_memToReg_in;
			control_regWrite_out <= control_regWrite_in;
			control_memWrite_out <= control_memWrite_in;
			control_memRead_out <= control_memRead_in;
			control_WE_out <= control_WE_in;
			control_TE_out <= control_TE_in;
			updated_pc_out <= updated_pc_in;
			from_register1_out <= from_register1_in;
			from_register2_out <= from_register2_in;
			from_IH_out<= from_IH_in;
			from_SP_out<= from_SP_in;
			from_imm_exp_out <= from_imm_exp_in;
			from_T_out <= from_T_in;
			from_instruction_7_5_out <= from_instruction_7_5_in;
			from_instruction_4_2_out <= from_instruction_4_2_in;
			from_instruction_10_8_out <= from_instruction_10_8_in;
		end if;
	end process;

end architecture ; -- behavioral