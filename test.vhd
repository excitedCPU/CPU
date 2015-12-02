----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:07:33 11/25/2015 
-- Design Name: 
-- Module Name:    test - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test is
	PORT(
		rst: in std_logic;
		instruction: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		result: out std_logic_vector(15 downto 0)
		);
end test;

architecture Behavioral of test is
COMPONENT commonRegister
	PORT(
		rst: IN std_logic;
		read_rx : IN std_logic_vector(2 downto 0);
		read_ry : IN std_logic_vector(2 downto 0);
		write_addr : IN std_logic_vector(2 downto 0);
		write_data : IN std_logic_vector(15 downto 0);
		regWrite : IN std_logic_vector(2 downto 0);          
		read_result1 : OUT std_logic_vector(15 downto 0);
		read_result2 : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	signal temp: std_logic_vector(15 downto 0);
	signal regWrite_tmp: std_logic_vector(2 downto 0);
begin
	regWrite_tmp(2 downto 1) <= "00";
	regWrite_tmp(0) <= clk;
	Inst_commonRegister: commonRegister PORT MAP(
		rst => rst,
		read_rx => instruction(15 downto 13),
		read_ry => instruction(12 downto 10),
		write_addr => instruction(2 downto 0),
		write_data => "0000111100001111",
		regWrite => regWrite_tmp,
		read_result1 => result,
		read_result2 => temp
	);
end Behavioral;

