library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ram is
	port (
		clk: in std_logic;
		rst: in std_logic;

		memWrite: in std_logic;
		memRead: in std_logic;

		write_data: in std_logic_vector(15 downto 0);
		target_addr: in std_logic_vector(15 downto 0);

		Rdata: out std_logic_vector(15 downto 0);

		Ram1EN: out std_logic;
		Ram1WE: out std_logic;
		Ram1OE: out std_logic;

		data: inout std_logic_vector(15 downto 0);
		ToRam_addr: out std_logic_vector(15 downto 0);

		wrn: out std_logic;
		rdn: out std_logic;
		data_ready: in std_logic;
		tbre: in std_logic;
		tsre: in std_logic
	);
end ram;


architecture behavioral of ram is
	signal mask: std_logic_vector(15 downto 0);
	signal com: std_logic_vector(15 downto 0);
	signal comVisit: std_logic := '0';
	signal crdn: std_logic;
	signal cwrn: std_logic;
begin
	RData <= (mask and data) or com;
	Ram1WE <= (not clk) or (not memWrite);
	Ram1OE <= (not clk) or (not memRead);
	Ram1EN <= (not clk) or comVisit; 
	rdn <= (not clk) or (not memRead) or (crdn);
	wrn <= (not clk) or (not memWrite) or (cwrn);

	process(clk)
	begin
		if (rising_edge(clk)) then
			if (target_addr = x"BF00" or target_addr = x"BF01") then
				
				comVisit <= '1';
				if (target_addr = x"BF01") then
					mask <= (others => '0');
					com(15 downto 2) <= (others => '0');
					com(1) <= data_ready;
					com(0) <= tbre and tsre;
					crdn <= '1';
					cwrn <= '1';
					data <= (others => 'Z');
				else
					com <= (others => '0');
					mask(15 downto 8) <= (others => '0');
					mask(7 downto 0) <= (others => '1');
					if (memWrite = '1') then
						crdn <= '1';
						cwrn <= '0';
						--ToRam_addr <= target_addr;
						data <= write_data;
					elsif (memRead = '1') then
						crdn <= '0';
						cwrn <= '1';
						data <= (others => 'Z');
					end if;
		
				end if;

			else
				com <= (others => '0');
				mask <= (others => '1');
				crdn <= '1';
				cwrn <= '1';
				comVisit <= '0';
				ToRam_addr <= target_addr;
				if (memWrite = '1') then
					data <= write_data;
				elsif (memRead = '1') then
					data <= (others => 'Z');
				end if;

			end if;
		end if;
	end process;

end architecture ; -- behavioral