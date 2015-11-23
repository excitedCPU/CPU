library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity riskCheck is
port(
	MemRead: in std_logic;
	Rtarget: in std_logic_vector(2 downto 0);
	Instructor: in std_logic_vector(15 downto 0);

	Nop: out std_logic;
	waitEnable: out std_logic
);
end riskCheck;

architecture behavioral of riskCheck is
begin
	process(MemRead, Rtarget, Instructor)
	begin
		Nop <= '0';
		waitEnable <= '0';

		case Instructor(15 downto 11) is
			when "01001" =>	--ADDIU 
				if (Rtarget = Instructor(10 downto 8)) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when "01000" =>	--ADDIU3
				if (Rtarget = Instructor(10 downto 8)) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when "01100" =>	--ADDSP BTEQZ BTNEZ MTSP 
				case Instructor(10 downto 8) is
					when "100" =>	--MTSP
						if (Rtarget = Instructor(7 downto 5)) then
							Nop <= '1';
							waitEnable <= '1';
						end if;

					when "011" => NULL;	--ADDSP		
					when "000" => NULL;	--BTEQZ
					when "001" => NULL;	--BTNEZ
					when others => NULL;
				end case;

			when "11100" => --ADDU SUBU
				case Instructor(1 downto 0) is
					when "01" =>	--ADDU
						if ((Rtarget = Instructor(10 downto 8)) or (Rtarget = Instructor(7 downto 5))) then
							Nop <= '1';
							waitEnable <= '1';
						end if;

					when "11" =>	--SUBU
						if ((Rtarget = Instructor(10 downto 8)) or (Rtarget = Instructor(7 downto 5))) then
							Nop <= '1';
							waitEnable <= '1';
						end if;

					when others => NULL;
				end case;

			when "00010" =>	NULL;	--B 

			when "00100" =>	--BEQZ
				if (Rtarget = Instructor(10 downto 8)) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when "00101" => --BNEZ
				if (Rtarget = Instructor(10 downto 8)) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when "11101" =>	--CMP JR MFPC OR SRLV 
				case Instructor(4 downto 0) is
					when "01010" => --CMP
						if ((Rtarget = Instructor(10 downto 8)) or (Rtarget = Instructor(7 downto 5))) then
							Nop <= '1';
							waitEnable <= '1';
						end if;

					when "00000" => --JR MFPC
						if ((Rtarget = Instructor(10 downto 8)) and (Instructor(7 downto 5) = "000")) then
							Nop <= '1';
							waitEnable <= '1';
						end if;

					when "01101" => --OR
						if ((Rtarget = Instructor(10 downto 8)) or (Rtarget = Instructor(7 downto 5))) then
							Nop <= '1';
							waitEnable <= '1';
						end if;

					when "00110" =>	--SRLV
						if ((Rtarget = Instructor(10 downto 8)) or (Rtarget = Instructor(7 downto 5))) then
							Nop <= '1';
							waitEnable <= '1';
						end if;												

					when others => NULL;
				end case;

			when "01101" =>	NULL;	--LI

			when "10011" =>	--LW
				if (Rtarget = Instructor(10 downto 8)) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when "10010" => NULL;	--LW_SP

			when "11110" =>	--MFIH MTIH
				case Instructor(4 downto 0) is
					when "00000" => NULL;	--MFIH
					when "00001" =>	--MTIH
						if (Rtarget = Instructor(10 downto 8)) then
							Nop <= '1';
							waitEnable <= '1';
						end if;

					when others => NULL;
				end case;
			
			when "01111" => --MOVE
				if (Rtarget = Instructor(7 downto 5)) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when "01100" => --MTSP
				if (Rtarget = Instructor(10 downto 8)) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when "00001" => NULL;	--NOP

			when "00110" => --SLL SRA SRL 
				case Instructor(1 downto 0) is
					when "00" =>	--SLL
						if (Rtarget = Instructor(7 downto 5)) then
							Nop <= '1';
							waitEnable <= '1';
						end if;		

					when "11" => 	--SRA
						if (Rtarget = Instructor(7 downto 5)) then
							Nop <= '1';
							waitEnable <= '1';
						end if;

					when "10" => 	--SRL
						if (Rtarget = Instructor(7 downto 5)) then
 							Nop <= '1';
 							waitEnable <= '1';
 						end if;

					when others => NULL;
				end case;

			when "01011" => --SLTUI
				if (Rtarget = Instructor(10 downto 8)) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when "11011" => --SW
				if ((Rtarget = Instructor(10 downto 8)) or (Rtarget = Instructor(7 downto 5))) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when "11010" =>	--SW_SP
				if (Rtarget = Instructor(10 downto 8)) then
					Nop <= '1';
					waitEnable <= '1';
				end if;

			when others => NULL;
		end case;
	end process;
end architecture ; -- behavioral