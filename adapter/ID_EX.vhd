library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity ID_EX is
	port (
		control_branchOrJump_in: in std_logic_vector(2 downto 0);
		control_desRegister_in: in std_logic_vector(1 downto 0);
		control_ALUsrc1_in: in std_logic_vector(2 downto 0);
		control_ALUsrc2_in: in std_logic_vector(2 downto 0);
		control_ALUop_in: in std_logic_vector(3 downto 0);
		control_memToReg_in: in std_logic_vector(2 downto 0);
		control_regWrite_in: in std_logic_vector(2 downto 0);
		control_memWrite_in: in std_logic;
		control_memRead_in: in std_logic;
		control_WE_in: in std_logic;
		control_TE_in: in std_logic;
		updated_pc_in: in std_logic_vector(15 downto 0);
		from_register1_in: in std_logic_vector(15 downto 0);
		from_register2_in: in std_logic_vector(15 downto 0);
		from_HI_SP_in: in std_logic_vector(15 downto 0);
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
		control_memToReg_out: out std_logic_vector(2 downto 0);
		control_regWrite_out: out std_logic_vector(2 downto 0);
		control_memWrite_out: out std_logic;
		control_memRead_out: out std_logic;
		control_WE_out: out std_logic;
		control_TE_out: out std_logic;
		updated_pc_out: out std_logic_vector(15 downto 0);
		from_register1_out: out std_logic_vector(15 downto 0);
		from_register2_out: out std_logic_vector(15 downto 0);
		from_HI_SP_out: out std_logic_vector(15 downto 0);
		from_imm_exp_out: out std_logic_vector(15 downto 0);
		from_T_out: out std_logic_vector(15 downto 0);
		from_instruction_7_5_out: out std_logic_vector(2 downto 0);
		from_instruction_4_2_out: out std_logic_vector(2 downto 0);
		from_instruction_10_8_out: out std_logic_vector(2 downto 0);
		);
end ID_EX;

architecture behavioral of ID_EX is

begin

end architecture ; -- behavioral