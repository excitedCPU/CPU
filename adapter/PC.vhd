library IEEE;
use IEEE.SED_LOGIC_1164.ALL;

entity PC is
	port (
		from_mux_pc: in std_logic;
		from_riskCheck: in std_logic;
		pc_out: out std_logic_vector(15 downto 0)
		);
end PC;

architecture behavioral of PC is

begin

end architecture ; -- behavioral