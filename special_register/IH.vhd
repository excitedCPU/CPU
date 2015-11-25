library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IH is
port(
	regWrite: in std_logic_vector(2 downto 0);
	writeData: in std_logic_vector(15 downto 0);

	IHData: out std_logic_vector(15 downto 0)
);
end IH;

architecture behavioral of IH is
	shared variable IH_register: std_logic_vector(15 downto 0);
begin

	process(regWrite)
	begin
		if (regWrite = "010") then
			IH_register := writeData;
		end if;
	end process;

	IHData <= IH_register;

end architecture ; -- behavioral