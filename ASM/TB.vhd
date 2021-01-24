library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB is end TB;

architecture TestBench of TB is
component CartaASM is
    Port(
        D : in STD_LOGIC_VECTOR(8 downto 0);
        INI,CLR,CLK : in STD_LOGIC;
        Qa : out STD_LOGIC_VECTOR(8 downto 0);
        DISPLAY : out STD_LOGIC_VECTOR(6 downto 0)
        );
end component;

signal D,Qa : STD_LOGIC_VECTOR(8 DOWNTO 0);
signal INI,CLR,CLK : STD_LOGIC := '0';
signal DISPLAY : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";

begin
    Clock: process
    begin
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
    end process;
    
    CASM : CartaASM
        Port map(
            D => D,
            Qa => Qa,
            INI => INI,
            CLR => CLR,
            CLK => CLK,
            DISPLAY => DISPLAY
            );
    process
        begin
        wait for 90ns;

        
        CLR <= '1';
        wait for 10 ns;
        CLR <= '0';
        
        
        D <= "101101011";
        INI <= '1';
        wait for 10 ns;
        INI <= '0';
        wait for 150 ns;
        
        
        D <= "000011101";
        INI <= '1';
        wait for 10 ns;
        INI <= '0';
        wait for 150 ns;
        
        
        INI <= '1';
        wait for 10 ns;
        D <= "000010000";
        INI <= '0';
        wait for 150 ns;
        
        
        D <= "100001000";
        INI <= '1';
        wait for 10 ns;
        INI <= '0';
        wait for 150 ns;
        
        
        D <= "000000000";
        INI <= '1';
        wait for 10 ns;
        INI <= '0';
        wait for 150 ns;
        
    end process;
    
end TestBench;
