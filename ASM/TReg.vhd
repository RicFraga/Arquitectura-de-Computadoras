library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TReg is end TReg;

architecture TB of TReg is
    component Reg is
        Port ( 
            Da : in STD_LOGIC_VECTOR (8 downto 0);
            Q : out STD_LOGIC_VECTOR (8 downto 0);
            LA,EA,CLK,CLR : in STD_LOGIC
           );    
    end component;
    
signal F,B0 : STD_LOGIC_VECTOR(8 downto 0) := "000000000";
signal B1,B2,CLK,CLR : STD_LOGIC := '0';
begin
    U0 : Reg
        Port map(
            Da => F,
            Q => B0,
            LA => B1,
            EA => B2,
            CLK => CLK,
            CLR => CLR
            );
            
    Clock: process
    begin
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
        CLR <= '1';
        wait for 30 ns;
        CLR <= '0';
        wait for 10 ns;
        F <= "111111110";
        B1 <= '1';
        B2 <= '0';
        wait for 20 ns;
        B1 <= '0';
        B2 <= '0';
        wait until rising_edge(CLK);
        B1 <= '0';
        B2 <= '1';
        wait for 100 ns;
        CLR <= '1';
        wait;
        
    end process;

end TB;
