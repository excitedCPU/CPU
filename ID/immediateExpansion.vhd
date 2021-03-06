library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity immediateExpansion is --path delay: 11.970ns
	port (
		instruction: in std_logic_vector(15 downto 0);
		imm_exp_result: out std_logic_vector(15 downto 0)
		);

end immediateExpansion;

architecture behavioral of immediateExpansion is
begin
	
	imm_exp_result <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16)) when instruction(15 downto 11) = "01001" else --ADDIU
					  std_logic_vector(resize(signed(instruction(3 downto 0)), 16)) when instruction(15 downto 11) = "01000" else --ADDIU3
					  std_logic_vector(resize(signed(instruction(7 downto 0)), 16)) when instruction(15 downto 11) = "01100" else --ADDSP BTEQZ BTNEZ
					  std_logic_vector(resize(signed(instruction(10 downto 0)), 16)) when instruction(15 downto 11) = "00010" else --B
					  std_logic_vector(resize(signed(instruction(7 downto 0)), 16)) when instruction(15 downto 11) = "00100" else --BEQZ
					  std_logic_vector(resize(signed(instruction(7 downto 0)), 16)) when instruction(15 downto 11) = "00101" else --BNEZ
					  std_logic_vector(resize(unsigned(instruction(7 downto 0)), 16)) when instruction(15 downto 11) = "01101" else --LI
					  std_logic_vector(resize(signed(instruction(4 downto 0)), 16)) when instruction(15 downto 11) = "10011" else --LW
					  std_logic_vector(resize(signed(instruction(7 downto 0)), 16)) when instruction(15 downto 11) = "10010" else --LW_SP
					  std_logic_vector(resize(unsigned(instruction(4 downto 2)), 16)) when instruction(15 downto 11) = "00110" else --SLL\SRA\SRL
					  std_logic_vector(resize(unsigned(instruction(7 downto 0)), 16)) when instruction(15 downto 11) = "01011" else --SLTUI
					  std_logic_vector(resize(signed(instruction(4 downto 0)), 16)) when instruction(15 downto 11) = "11011" else --SW
					  std_logic_vector(resize(signed(instruction(7 downto 0)), 16)) when instruction(15 downto 11) = "11010" else --SW_SP
					  std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
	
	
--	expand: process(instruction)
--	variable operation: std_logic_vector(4 downto 0);
--	begin
--		operation:= instruction(15 downto 11);
--		case operation is
--			when "01001" => --ADDIU
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
--			when "01000" => --ADDIU3
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(3 downto 0)), 16));
--			when "01100" => --ADDSP BTEQZ BTNEZ
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
--			when "00010" => --B
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(10 downto 0)), 16));
--			when "00100" => --BEQZ
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
--			when "00101" => --BNEZ
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
--			when "01101" => --LI
--				imm_exp_result <= std_logic_vector(resize(unsigned(instruction(7 downto 0)), 16));
--			when "10011" => --LW
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(4 downto 0)), 16));
--			when "10010" => --LW_SP
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
--			when "00110" => --SLL\SRA\SRL
--				imm_exp_result <= std_logic_vector(resize(unsigned(instruction(4 downto 2)), 16));
--			when "01011" => --SLTUI
--				imm_exp_result <= std_logic_vector(resize(unsigned(instruction(7 downto 0)), 16));
--			when "11011" => --SW
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(4 downto 0)), 16));
--			when "11010" => --SW_SP
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
--			when others => --other instruction and states
--				imm_exp_result <= std_logic_vector(resize(signed(instruction(7 downto 0)), 16));
--		end case;
--	end process;

end architecture ; -- behavioral