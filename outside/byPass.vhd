library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity byPass is
port(
	ALUsrc1: in std_logic_vector(2 downto 0);
	ALUsrc2: in std_logic_vector(2 downto 0);
	ME_ReqWrite: in std_logic_vector(2 downto 0);
	WB_ReqWrite: in std_logic_vector(2 downto 0);
	T_Enable: in std_logic;

	rx_addr: in std_logic_vector(2 downto 0);
	ry_addr: in std_logic_vector(2 downto 0);
	
	ME_target: in std_logic_vector(2 downto 0);
	WB_target: in std_logic_vector(2 downto 0);

	Fsrc1: out std_logic_vector(1 downto 0);
	Fsrc2: out std_logic_vector(1 downto 0);
	Fbranch: out std_logic_vector(1 downto 0);
	
	Control_WC: in std_logic;
	FmemData: out std_logic_vector(1 downto 0)
);
end byPass;

architecture behavioral of byPass is

begin

	out_FmemData: process(control_WC, ME_ReqWrite, WB_ReqWrite, rx_addr, ry_addr, ME_target, WB_target)
	begin
		FmemData <= "00";
		if (Control_WC = '0') then
			if (ME_target = rx_addr and ME_ReqWrite = "000") then
				FmemData <= "01";
			elsif (WB_target = rx_addr and WB_ReqWrite = "000") then
				FmemData <= "10";
			end if;
		elsif (Control_WC = '1') then
			if (ME_target = ry_addr and ME_ReqWrite = "000") then
				FmemData <= "01";
			elsif (WB_target = ry_addr and WB_ReqWrite = "000") then
				FmemData <= "10";
			end if;			
		end if;
	end process;
	
	out_Fsrc1: process(ALUsrc1, ME_ReqWrite, WB_ReqWrite, rx_addr, ME_target, WB_target)
	begin
		Fsrc1 <= "00";
		if (ALUsrc1 = "000") then

			if (rx_addr = ME_target and ME_ReqWrite = "000") then
				Fsrc1 <= "01";
			elsif (rx_addr = WB_target and WB_ReqWrite = "000") then
				Fsrc1 <= "10";
			end if;

		elsif (ALUsrc1 = "010") then

			if (ME_ReqWrite = "011") then
				Fsrc1 <= "01";
			elsif (WB_ReqWrite = "011") then
				Fsrc1 <= "10";
			end if;

		elsif (ALUsrc1 = "100") then

			if (ME_ReqWrite = "010") then
				Fsrc1 <= "01";
			elsif (WB_ReqWrite = "010") then
				Fsrc1 <= "10";
			end if;

		end if;
	end process;

	out_Fsrc2: process(ALUsrc2, ME_ReqWrite, WB_ReqWrite, ry_addr, ME_target, WB_target)
	begin
		Fsrc2 <= "00";
		if (ALUsrc2 = "000") then

			if (ry_addr = ME_target and ME_ReqWrite = "000") then 
				Fsrc2 <= "01";
			elsif (ry_addr = WB_target and WB_ReqWrite = "000") then
				Fsrc2 <= "10";
			end if;

		elsif (ALUsrc2 = "010") then

			if (ME_ReqWrite = "011") then
				Fsrc2 <= "01";
			elsif (WB_ReqWrite = "011") then
				Fsrc2 <= "10";
			end if;

		elsif (ALUsrc2 = "100") then

			if (ME_ReqWrite = "010") then
				Fsrc2 <= "01";
			elsif (WB_ReqWrite = "010") then
				Fsrc2 <= "10";
			end if;
			
		end if;
	end process;


	out_T: process(T_Enable, ME_ReqWrite, WB_ReqWrite, rx_addr, ME_target, WB_target)
	begin
		Fbranch <= "00";
		if (T_Enable = '1') then
			if (ME_ReqWrite = "001") then
				Fbranch <= "01";
			elsif (WB_ReqWrite = "001") then
				Fbranch <= "10";
			end if;
		elsif (T_Enable = '0') then
			if (rx_addr = ME_target and ME_ReqWrite = "000") then
				Fbranch <= "01";
			elsif (rx_addr = WB_target and WB_ReqWrite = "000") then
				Fbranch <= "10";
			end if;
		end if;
	end process;
end architecture ; -- behavioral