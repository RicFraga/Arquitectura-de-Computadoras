
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_alu1b is
--  Port ( );
end tb_alu1b;

architecture Behavioral of tb_alu1b is


component alu1b is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           selA : in STD_LOGIC;
           selB : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Op : in STD_LOGIC_VECTOR (1 downto 0);
           Cout : out STD_LOGIC;
           res : out STD_LOGIC);
end component;


signal A : STD_LOGIC;
signal B : STD_LOGIC;
signal selA : STD_LOGIC;
signal selB : STD_LOGIC;
signal Cin : STD_LOGIC;
signal Op : STD_LOGIC_VECTOR (1 downto 0);
signal Cout : STD_LOGIC;
signal res : STD_LOGIC;

begin

objeto1: alu1b port map (
    A => A,
    B => B,
    selA => selA,
    selB => selB,
    Cin => Cin,
    Op => Op,
    Cout => Cout,
    res => res  
);


uno: process
begin

    A <= '1';
    B <= '1';
    selA <= '0';
    selB <= '0';
    Cin <= '0';
    Op <= "00";
    
    wait for 100ns;
    
    A <= '0';
    B <= '0';
    selA <= '0';
    selB <= '0';
    Cin <= '0';
    Op <= "01";
    
    wait for 100ns;
    
    A <= '1';
    B <= '0';
    selA <= '0';
    selB <= '0';
    Cin <= '0';
    Op <= "10";
    
    wait for 100ns;
    
    A <= '1';
    B <= '0';
    selA <= '0';
    selB <= '0';
    Cin <= '0';
    Op <= "11";
    
    wait for 100ns;
    
end process;

end Behavioral;
