library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ram is
	port (
		clk: in std_logic;
		rst: in std_logic;
		ram_addr_in: in std_logic_vector(15 downto 0);
		--read_enable: in std_logic;
		--write_enable: in std_logic;
		ram1_en: out std_logic;
		data: inout std_logic_vector(15 downto 0);
		OE_L: out std_logic;
		WE_L: out std_logic;
		ram_addr_out: out std_logic_vector(17 downto 0);
		ram_out: out std_logic_vector(15 downto 0)
		);
end ram;


architecture behavioral of ram is

	type status is (WORK, RESTORE);
	signal current_status: status := WORK;
	signal next_status: status := WORK;
	signal read_enable: std_logic := '1';
	signal write_enable: std_logic := '0';

begin
	read_enable <= '1';
	write_enable <= '0';
	ram1_en <= '0';
	ram_addr_out(17 downto 16) <= "00";
	ram_addr_out(15 downto 0) <= ram_addr_in;

	time_control: process(clk, rst)
	begin
		if rst = '0' then
			current_status <= WORK;
		elsif clk'event and clk = '0' then
			current_status <= next_status;
		end if;
	end process;

	status_control: process(rst, current_status)
	begin
		if rst = '0' then
			next_status <= WORK;
		end if;
		next_status <= RESTORE;
		case current_status is
			when RESTORE => next_status <= WORK;
			when WORK => next_status <= RESTORE;
		end case;
	end process;

	logic_control: process(clk, current_status, data, read_enable, write_enable)
	begin
		if clk'event and clk = '0' then
			case current_status is
			when WORK =>
				if write_enable = '1' then
					WE_L <= '0';
				elsif read_enable = '1' then
					OE_L <= '0';
					data <= "ZZZZZZZZZZZZZZZZ";
				end if;
			when RESTORE =>
				WE_L <= '1';
				OE_L <= '1';

			end case;
		end if;
	end process;

	ram_out <= data;

end architecture ; -- behavioral