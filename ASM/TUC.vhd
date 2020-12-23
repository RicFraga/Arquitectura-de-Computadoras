library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TUC is end TUC;

architecture TB of TUC is
    component UC is
        Port(
            CLK,CLR,INI,Z,A0    : in STD_LOGIC;
            LA,LB,EA,EB,EC      : out STD_LOGIC
            );
    end component;
    
signal CLK,CLR,INI,B0,B1,B2,B3,B4,B5,B6 : STD_LOGIC := '0';

begin
    Clock: process
    begin
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
    end process;
    
    U1 : UC
        Port map(
            CLK => CLK,
            CLR => CLR,
            INI => INI,
            Z => B0,
            A0 => B1,
            LA => B2,
            LB => B3,
            EA => B4,
            EB => B5,
            EC => B6
            );
    
    process
    begin
        CLR <= '1';
        wait for 30 ns;
        CLR <= '0';
        wait for 60 ns;
        INI <= '1';
        wait for 10 ns;
        INI <= '0';
        wait for 50 ns;
        B1 <= '1';
        wait for 10 ns;
        B1 <= '0';
        wait for 20 ns;
        B1 <= '1';
        wait for 10 ns;
        B1 <= '0';
        wait for 120 ns;
        b0 <= '1';
        wait;
        
    end process;

end TB;
