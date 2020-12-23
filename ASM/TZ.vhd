library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TZ is end TZ;

architecture TB of TZ is
    component C_NOR is
        Port(
            B0 : in STD_LOGIC_VECTOR(8 downto 0);
            A0 : out STD_LOGIC
         );
    end component;
signal B0 : STD_LOGIC_VECTOR(8 downto 0);
signal B1 : STD_LOGIC;

begin
    ZERO : C_NOR
        Port map(
            B0 => B0,
            A0 => B1
            );
    
    process
    begin
        B0 <= "010101010";
        wait for 5 ns;
        B0 <= "111101010";
        wait for 5 ns;
        B0 <= "011101010";
        wait for 5 ns;
        B0 <= "010111010";
        wait for 5 ns;
        B0 <= "010100010";
        wait for 5 ns;
        B0 <= "000000000";
        wait for 5 ns;
        B0 <= "011111111";
        wait for 5 ns;
        B0 <= "111111111";
        wait;
    end process;

end TB;
