library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity EX_manager is
	port (
		control_branchOrJump: in std_logic_vector(2 downto 0);
		control_desRegister: in std_logic_vector(1 downto 0);
		control_ALUsrc1: in std_logic_vector(2 downto 0);
		control_ALUsrc2: in std_logic_vector(2 downto 0);
		control_ALUop: in std_logic_vector(3 downto 0);
		control_memToReg: in std_logic_vector(2 downto 0);
		control_regWrite: in std_logic_vector(2 downto 0);
		control_memWrite: in std_logic;
		control_memRead: in std_logic;
		control_WE: in std_logic;
		control_TE: in std_logic;
		updated_pc: in std_logic_vector(15 downto 0);
		from_register1: in std_logic_vector(15 downto 0);
		from_register2: in std_logic_vector(15 downto 0);
		from_HI_SP: in std_logic_vector(15 downto 0);
		from_imm_exp: in std_logic_vector(15 downto 0);
		from_T: in std_logic_vector(15 downto 0);
		from_instruction_7_5: in std_logic_vector(2 downto 0);
		from_instruction_4_2: in std_logic_vector(2 downto 0);
		from_instruction_10_8: in std_logic_vector(2 downto 0);

		out_memToReg: out std_logic_vector(2 downto 0);
		out_regWrite: out std_logic_vector(2 downto 0);
		out_memWrite: out std_logic;
		out_memRead: out std_logic;
		ALUresult: out std_logic_vector(15 downto 0);
		mux_writeRamData: out std_logic_vector(15 downto 0);
		mux_desRegister: out std_logic_vector(15 downto 0)
		);
end EX_manager;

architecture behavioral of EX_manager is

begin

end architecture ; -- behavioral