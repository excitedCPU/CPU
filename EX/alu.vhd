library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--9.18ns
entity ALU is
	port (
		ALUsrc1: in std_logic_vector(15 downto 0);
		ALUsrc2: in std_logic_vector(15 downto 0);
		control_ALUop: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(15 downto 0);
		sum: out std_logic_vector(15 downto 0)
		);
end ALU;

architecture behavioral of ALU is
begin
	process(ALUsrc1, ALUsrc2, control_ALUop)
	variable one: signed(15 downto 0) := "1111111111111111";
	begin
		case control_ALUop is
			when "0000" => --ADD
				result <= std_logic_vector(signed(ALUsrc1) + signed(ALUsrc2));
			when "0001" => --AND
				result <= ALUsrc1 and ALUsrc2;
			when "0100" => --equal
				if signed(ALUsrc1) = signed(ALUsrc2) then
					result <= "0000000000000001"; --16bit
				elsif signed(ALUsrc1) = signed(ALUsrc2) then
					result <= "0000000000000000"; --16bit
				end if;
			when "0110" => --OR 
				result <= ALUsrc1 or ALUsrc2;
			when "0111" => --equal then shift left
				--src1 imm src2 register
				if unsigned(ALUsrc1) = 0 then
					result <= std_logic_vector(shift_left(unsigned(ALUsrc2), 8));
				elsif unsigned(ALUsrc1) /= 0 then
					result <= std_logic_vector(shift_left(unsigned(ALUsrc2), to_integer(unsigned(ALUsrc1(3 downto 0)))));
				end if;
			when "1000" => --less then
				if unsigned(ALUsrc2) < 0 then
					result <= "0000000000000001";
				elsif unsigned(ALUsrc2) >= 0 then
					result <= "0000000000000000";
				end if;
			when "1001" => --equal then shift right
				if unsigned(ALUsrc1) = 0 then --arith shift right 8
					result <= std_logic_vector(shift_right(signed(ALUsrc2), 8));
				elsif unsigned(ALUsrc1) /= 0 then --arith shift right imm
					result <= std_logic_vector(shift_right(signed(ALUsrc2), to_integer(unsigned(ALUsrc1(3 downto 0)))));
				end if;
			when "1010" => --shift right
				result <= std_logic_vector(shift_right(unsigned(ALUsrc2), to_integer(unsigned(ALUsrc1(3 downto 0)))));
			when "1011" => --minus
				result <= std_logic_vector(signed(ALUsrc1) - signed(ALUsrc2));
			when "1110" => --assign first opnum
				result <= ALUsrc1;
			when "1111" => --assign second opnum
				result <= ALUsrc2;
			when others => --zero
				result <= "0000000000000000";
		end case;
		sum <= std_logic_vector(unsigned(ALUsrc1) + unsigned(ALUsrc2));
	end process;
end architecture ; -- behavioral