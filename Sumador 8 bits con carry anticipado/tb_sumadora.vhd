
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_sumadora is
--  Port ( );
end tb_sumadora;

architecture Behavioral of tb_sumadora is

component sumador_carrya is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Cout : out STD_LOGIC);
end component;


signal A : STD_LOGIC_VECTOR (7 downto 0);
signal B : STD_LOGIC_VECTOR (7 downto 0);
signal S : STD_LOGIC_VECTOR (7 downto 0);
signal Cout : STD_LOGIC;

begin

objeto1: sumador_carrya port map
(
    A => A,
    B => B,
    S => S,
    Cout => Cout
);

uno: process
begin

    -- a = 23, b = 87
    -- a + b
    A <= "00010111";
    B <= "01010111";
    wait for 50ns;
    
    -- a = 26, b = 95
    -- a + b
    A <= "00011010";
    B <= "01011111";
    wait for 50ns;
    
    -- a = 41, b = 98
    -- a + b
    A <= "00101001";
    B <= "01100010";
    wait for 50ns;
    
    -- a = 186, b = 36
    -- a - b
    A <= "10111010";
    B <= "00100100";
    wait for 50ns;
    
    -- a = 63, b = 98
    -- a + b
    A <= "00111111";
    B <= "01100010";
    wait for 50ns;
    
    -- a = 60, b = 15
    -- a - b
    A <= "00111100";
    B <= "00001111";
    wait for 50ns;
    
    -- a = 120, b = 48
    -- a - b
    A <= "01111000";
    B <= "00110000";
    wait for 50ns;
    
    -- a = 11, b = 8
    -- a - b
    A <= "00001011";
    B <= "00001000";
    wait for 50ns;
    
    -- a = 1, b = 4
    -- a - b
    A <= "00000001";
    B <= "00000100";
    wait for 50ns;

end process;

end Behavioral;
