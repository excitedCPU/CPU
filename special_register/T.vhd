library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T is
port(
	regWrite: in std_logic_vector(2 downto 0);
	writeData: in std_logic_vector(15 downto 0);

	TData: out std_logic_vector(15 downto 0)
);
end T;

architecture behavioral of T is
	shared variable T_register: std_logic_vector(15 downto 0);
begin
	
	process(regWrite)
	begin
		if (regWrite = "001") then
			T_register := writeData;
		end if;
	end process;

	TData <= T_register;

end architecture ; -- behavioral