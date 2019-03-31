----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2019 04:11:31 PM
-- Design Name: 
-- Module Name: vga_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_tb is
--  Port ( );
end vga_tb;

architecture Behavioral of vga_tb is
signal clk, en, vs, hs, vid : std_logic :='0';

signal hcount, vcount : STD_LOGIC_VECTOR (9 downto 0);

component vga_ctrl Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           hcount : out STD_LOGIC_VECTOR (9 downto 0);
           vcount : out STD_LOGIC_VECTOR (9 downto 0);
           vid : out STD_LOGIC;
           vs : out STD_LOGIC;
           hs : out STD_LOGIC);
end component;

begin
clock: process begin
    clk <= not clk;
    wait for 4 ns;
end process;

enable: process begin
    wait for 64 ns;
    en <= not en;
end process;

Test: vga_ctrl Port map(
    clk => clk,
    en => en,
    hcount => hcount,
    hs => hs,
    vid => vid);



end Behavioral;
