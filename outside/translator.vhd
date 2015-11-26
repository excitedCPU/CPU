LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity translator is
	port(
		input_bits: in std_logic_vector(7 downto 0);
		H: out std_logic_vector(6 downto 0);
		L: out std_logic_vector(6 downto 0)
	);
end translator;

architecture translate of translator is
begin
	--tem_q <= conv_std_logic_vector(int_q,6);
	process(input_bits)
	begin
		case input_bits(3 downto 0) is
			when "0000" => L <= "1111110";
			when "0001" => L <= "0110000";
			when "0010" => L <= "1101101";
			when "0011" => L <= "1111001";
			when "0100" => L <= "0110011";
			when "0101" => L <= "1011011";
			when "0110" => L <= "1011111";
			when "0111" => L <= "1110000";
			when "1000" => L <= "1111111";
			when "1001" => L <= "1110011";
			when "1010" => L <= "1110111";
			when "1011" => L <= "0011111";
			when "1100" => L <= "1001110";
			when "1101" => L <= "0111101"; --D
			when "1110" => L <= "1001111"; --E
			when "1111" => L <= "1000111"; --F
			when others => L <= "0000000";
		end case;
		case input_bits(7 downto 4) is
			when "0000" => H <= "1111110";
			when "0001" => H <= "0110000";
			when "0010" => H <= "1101101";
			when "0011" => H <= "1111001";
			when "0100" => H <= "0110011";
			when "0101" => H <= "1011011";
			when "0110" => H <= "1011111";
			when "0111" => H <= "1110000";
			when "1000" => H <= "1111111";
			when "1001" => H <= "1110011";
			when "1010" => H <= "1110111";
			when "1011" => H <= "0011111";
			when "1100" => H <= "1001110";
			when "1101" => H <= "0111101"; --D
			when "1110" => H <= "1001111"; --E
			when "1111" => H <= "1000111"; --F
			when others => H <= "0000000";
		end case;
	end process;
end translate;