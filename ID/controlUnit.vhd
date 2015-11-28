library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controlUnit is
	port (
		instruction: in std_logic_vector(15 downto 0);
		from_risk_check: in std_logic;
		from_branch_control: in std_logic;

		branchOrJump: out std_logic_vector(2 downto 0);
		desRegister: out std_logic_vector(1 downto 0);
		ALUsrc1: out std_logic_vector(2 downto 0);
		ALUsrc2: out std_logic_vector(2 downto 0);
		ALUop: out std_logic_vector(3 downto 0);
		memToReg: out std_logic;
		regWrite: out std_logic_vector(2 downto 0);
		memWrite: out std_logic;
		memRead: out std_logic;
		WC: out std_logic;
		T_Enable: out std_logic
		);

end controlUnit;

architecture behavioral of controlUnit is

begin
	process(instruction, from_risk_check, from_branch_control)
	begin
		branchOrJump <= "000";
		desRegister <= "00";
		ALUsrc1 <= "000";
		ALUsrc2 <= "000";
		ALUop <= "0000";
		memToReg <= '0';
		regWrite <= "000";
		memWrite <= '0';
		memRead <= '0';
		WC <= '0';
		T_Enable <= '0';		

		if (from_risk_check = '1' or from_branch_control = '1') then
			ALUsrc1 <= "111";
			ALUsrc2 <= "111";
			regWrite <= "100";
		elsif (from_branch_control = '0' and from_risk_check = '0') then 
			case instruction(15 downto 11) is
				when "01001" => --ADDIU
					ALUsrc2 <= "001";

				when "01000" => --ADDIU3
					desRegister <= "01";
					ALUsrc2 <= "001";

				when "01100" => --ADDSP BTEQZ BTNEZ MTSP 
					case instruction(10 downto 8) is
						when "100" =>	--MTSP
							ALUsrc1 <= "111";
							ALUop <= "1111";
							regWrite <= "011";

						when "011" => 	--ADDSP
							ALUsrc1 <= "010";
							ALUsrc2 <= "001";
							regWrite <= "011";


						when "000" => 	--BTEQZ
							branchOrJump <= "011";
							ALUsrc1 <= "011";
							ALUsrc2 <= "001";
							regWrite <= "100";
							T_Enable <= '1';


						when "001" => 	--BTNEZ
							branchOrJump <= "111";
							ALUsrc1 <= "011";
							ALUsrc2 <= "001";
							regWrite <= "100";
							T_Enable <= '1';

						when others => NULL;
					end case;

				when "11100" => --ADDU SUBU
					case instruction(1 downto 0) is
						when "01" =>	--ADDU
							desRegister <= "10";

						when "11" =>	--SUBU
							desRegister <= "10";
							ALUop <= "1011";

						when others => NULL;
					end case;

				when "00010" =>	--B
					branchOrJump <= "001";
					ALUsrc1 <= "011";
					ALUsrc2 <= "001";
					regWrite <= "100";

				when "00100" =>	--BEQZ
					branchOrJump <= "010";
					ALUsrc1 <= "011";
					ALUsrc2 <= "001";
					regWrite <= "100";

				when "00101" => --BNEZ
					branchOrJump <= "110";
					ALUsrc1 <= "011";
					ALUsrc2 <= "001";
					regWrite <= "100";

				when "11101" =>	--CMP JR MFPC OR SRLV AND
					case instruction(4 downto 0) is
						when "01010" => --CMP
							ALUop <= "0100";
							regWrite <= "001";

						when "00000" => --JR MFPC
							if (instruction(7 downto 5) = "000") then	--JR
								branchOrJump <= "100";
								ALUsrc2 <= "111";
								ALUop <= "1110";
								regWrite <= "100";
							elsif (instruction(7 downto 5) = "010") then 										--MFPC
								ALUsrc1 <= "011";
								ALUsrc2 <= "111";
								ALUop <= "1110";
							end if;


						when "01101" => --OR
							ALUop <= "0110";

						when "00110" =>	--SRLV
							desRegister <= "01";
							ALUop <= "1010";

						when "01100" => --AND
							ALUop <= "0001";

						when others => NULL;
					end case;


				when "01101" =>	--LI
					ALUsrc1 <= "001";
					ALUsrc2 <= "111";
					ALUop <= "1110";

				when "10011" =>	--LW
					desRegister <= "01";
					ALUsrc2 <= "001";
					memToReg <= '1';
					memRead <= '1';

				when "10010" => --LW_SP
					ALUsrc1 <= "010";
					ALUsrc2 <= "001";
					memToReg <= '1';
					memRead <= '1';

				when "11110" =>	--MFIH MTIH
					case instruction(4 downto 0) is
						when "00000" =>	--MFIH
							ALUsrc1 <= "100";
							ALUsrc2 <= "111";
							ALUop <= "1110";

						when "00001" =>	--MTIH
							ALUsrc2 <= "111";
							ALUop <= "1110";
							regWrite <= "010";

						when others => NULL;
					end case;
				
				when "01111" => --MOVE
					ALUsrc1 <= "111";
					ALUsrc2 <= "111";

				when "00001" =>	--NOP
					ALUsrc1 <= "111";
					ALUsrc2 <= "111";
					regWrite <= "100";

				when "00110" => --SLL SRA SRL 
					case instruction(1 downto 0) is
						when "00" =>	--SLL
							ALUsrc1 <= "001";
							ALUop <= "0111";

						when "11" => 	--SRA
							ALUsrc1 <= "001";
							ALUop <= "1001";

						when "10" => 	--SRL
							ALUsrc1 <= "001";
							ALUop <= "1001";

						when others => NULL;
					end case;

				when "01011" => --SLTUI
					ALUsrc2 <= "001";
					ALUop <= "1000";
					regWrite <= "001";

				when "11011" => --SW
					ALUsrc2 <= "001";
					regWrite <= "100";
					memWrite <= '1';
					WC <= '1';

				when "11010" =>	--SW_SP
					ALUsrc1 <= "010";
					ALUsrc2 <= "001";
					regWrite <= "100";
					memWrite <= '1';

				when others => NULL;
			end case;
		end if;
	end process;

end architecture ; -- behavioral

--package C_SIGNAL is
--	CONSTANT TEST_SIGNAL: std_logic_vector(2 downto 0) := "111";
--end C_SIGNAL;