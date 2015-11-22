library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity IF_ID is
	port (
		from_riskCheck: in std_logic;
		updated_pc_in: in std_logic_vector(15 downto 0);
		instruction_in: in std_logic_vector(15 downto 0);
		updated_pc_out: out std_logic_vector(15 downto 0);
		instruction_out: out std_logic_vector(15 downto 0);
		);
end IF_ID;

architecture behavioral of IF_ID is

begin

end architecture ; -- behavioral