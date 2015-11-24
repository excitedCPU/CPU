library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity branchControl is
port(
	--debug: out std_logic_vector(4 downto 0);
	rx: in std_logic_vector(15 downto 0);
	T: in std_logic_vector(15 downto 0);
	ME_Value: in std_logic_vector(15 downto 0);
	WB_Value: in std_logic_vector(15 downto 0);

	BranchOrJump: in std_logic_vector(2 downto 0);
	Fbranch: in std_logic_vector(1 downto 0);

	PC_Choose: out std_logic;
	kill: out std_logic
);
end branchControl;

architecture behavioral of branchControl is
begin
	process(rx, T, ME_Value, WB_Value, BranchOrJump, Fbranch)
		variable tmp: std_logic_vector(15 downto 0);
		variable zeros: std_logic_vector(15 downto 0) := "0000000000000000";
	begin
		--debug(2 downto 0) <= BranchOrJump;
		--debug(4 downto 3) <= Fbranch;
		PC_Choose <= '0';
		kill <= '0';

		if (BranchOrJump = "001" or BranchOrJump = "100") then

			PC_Choose <= '1';
			kill <= '1';

		elsif (BranchOrJump = "010" or BranchOrJump = "110") then

			case Fbranch is
				when "00" =>
					tmp := rx;
				when "01" =>
					tmp := ME_Value;
				when "10" =>
					tmp := WB_Value;
				when "11" =>
					tmp := rx;
					
				when others => null;
			end case;

			if ((tmp = zeros and BranchOrJump = "010") or (not (tmp = zeros) and BranchOrJump = "110")) then
				PC_Choose <= '1';
				kill <= '1';
			end if;

		elsif (BranchOrJump = "011" or BranchOrJump = "111") then

			case Fbranch is
				when "00" =>
					tmp := T;
				when "01" =>
					tmp := ME_Value;
				when "10" =>
					tmp := WB_Value;
				when "11" =>
					tmp := T;
					
				when others => null;
			end case;

			if ((tmp = zeros and BranchOrJump = "011") or (not (tmp = zeros) and BranchOrJump = "111")) then
				PC_Choose <= '1';
				kill <= '1';
			end if;

		end if;

	end process;
end architecture ; -- behavioral