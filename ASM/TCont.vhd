library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TCont is end TCont;

architecture Behavioral of TCont is
    component Contador is
        Port(
            LB,EB,CLK,CLR : in STD_LOGIC;
            Qb : out STD_LOGIC_VECTOR(3 DOWNTO 0)
            );
    end component;
signal B0,B1,CLK,CLR : STD_LOGIC := '0';
signal B2 : STD_LOGIC_VECTOR(3 DOWNTO 0);

begin
    
    Clock: process
    begin
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
    end process;
        
    U2 : Contador
        Port map(
            LB => B0,
            EB => B1,
            CLK => CLK,
            CLR => CLR, 
            Qb => B2
        );
        
    process
    begin
        CLR <= '1';
        wait for 10 ns;
        
        CLR <= '0';
        B0 <= '1';
        B1 <= '0';
        wait until rising_edge(CLK);
        
        B0 <= '0';
        B1 <= '1';
        wait for 60 ns;
        
        B0 <= '0';
        B1 <= '0';
        wait for 50 ns;
        
        B0 <= '0';
        B1 <= '1';
        wait for 30 ns;
        
    end process;

end Behavioral;
