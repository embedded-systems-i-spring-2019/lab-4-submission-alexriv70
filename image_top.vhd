----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2019 03:01:07 PM
-- Design Name: 
-- Module Name: image_top - Behavioral
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

entity image_top is
    Port ( clk : in STD_LOGIC;
           vga_hs : out STD_LOGIC;
           vga_vs : out STD_LOGIC;
           vga_r : out STD_LOGIC_VECTOR (4 downto 0);
           vga_b : out STD_LOGIC_VECTOR (4 downto 0);
           vga_g : out STD_LOGIC_VECTOR (5 downto 0));
end image_top;

architecture Behavioral of image_top is

component pixel_pusher is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           vs, vid : in STD_LOGIC;
           pixel : in STD_LOGIC_VECTOR (7 downto 0);
           hcount : in STD_LOGIC_VECTOR (9 downto 0);
           R, B : out STD_LOGIC_VECTOR (4 downto 0);
           G : out STD_LOGIC_VECTOR (5 downto 0);
           addr : out STD_LOGIC_VECTOR (17 downto 0));
end component;

component clock_div is
    Port ( clk_in : in STD_LOGIC;
           div : out STD_LOGIC);
end component;

component vga_ctrl is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           hcount : out STD_LOGIC_VECTOR (9 downto 0);
           vcount : out STD_LOGIC_VECTOR (9 downto 0);
           vid : out STD_LOGIC;
           vs : out STD_LOGIC;
           hs : out STD_LOGIC);
end component;

component picture is
    Port  (
   clka : IN STD_LOGIC;
   addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
   douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
 ); end component;

signal en : STD_LOGIC;
signal pixel : STD_LOGIC_VECTOR (7 downto 0);
signal addr : std_logic_vector (17 downto 0);

signal hcount, vcount : STD_LOGIC_VECTOR (9 downto 0);
signal vid , vs, hs: STD_LOGIC;


begin

vga_vs <= vs;


    u1: clock_div port map (
        clk_in => clk,
        div => en
        );
    u2: vga_ctrl port map (
        clk => clk,
        en => en,
        hcount => hcount,
        vcount => vcount,
        vid => vid,
        vs => vs,
        hs => vga_hs
        );
    u3: pixel_pusher port map (
        clk => clk,
        en => en,
        vs => vs,
        hcount => hcount,
        R => vga_r,
        G => vga_g,
        B => vga_b,
        addr => addr,
        vid => vid,
        pixel => pixel
        );
    u4: picture port map (
        clka => en,
        addra => addr,
        douta => pixel);
end Behavioral;
