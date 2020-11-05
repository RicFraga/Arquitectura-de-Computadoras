
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tbSumadorRestador is
--  Port ( );
end tbSumadorRestador;

architecture Behavioral of tbSumadorRestador is

component sumador_restador is
    Port ( a, b : in STD_LOGIC_VECTOR (7 downto 0);
           Co : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Ca: out STD_LOGIC);
end component;


signal a, b : STD_LOGIC_VECTOR (7 downto 0);
signal Co : STD_LOGIC;
signal S :STD_LOGIC_VECTOR (7 downto 0);
signal Ca: STD_LOGIC;

begin

objeto1 : sumador_restador port map
    (a => a,
     b => b,
     Co => Co, 
     S => S,
     Ca => Ca);

uno: process 
begin
    
    -- a = 23, b = 87
    -- a + b
    a <= "00010111";
    b <= "01010111";
    Co <= '0';
    wait for 50ns;
    
    -- a = 26, b = 95
    -- a + b
    a <= "00011010";
    b <= "01011111";
    Co <= '0';
    wait for 50ns;
    
    -- a = 41, b = 98
    -- a + b
    a <= "00101001";
    b <= "01100010";
    Co <= '0';
    wait for 50ns;
    
    -- a = 186, b = 36
    -- a - b
    a <= "10111010";
    b <= "00100100";
    Co <= '1';
    wait for 50ns;
    
    -- a = 63, b = 98
    -- a + b
    a <= "00111111";
    b <= "01100010";
    Co <= '0';
    wait for 50ns;
    
    -- a = 60, b = 15
    -- a - b
    a <= "00111100";
    b <= "00001111";
    Co <= '1';
    wait for 50ns;
    
    -- a = 120, b = 48
    -- a - b
    a <= "01111000";
    b <= "00110000";
    Co <= '1';
    wait for 50ns;
    
    -- a = 11, b = 8
    -- a - b
    a <= "00001011";
    b <= "00001000";
    Co <= '1';
    wait for 50ns;
    
    -- a = 1, b = 4
    -- a - b
    a <= "00000001";
    b <= "00000100";
    Co <= '1';
    wait for 50ns;
end process;

end Behavioral;
