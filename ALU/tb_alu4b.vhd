
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_alu4b is
--  Port ( );
end tb_alu4b;

architecture Behavioral of tb_alu4b is

component alu4b is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           selA : in STD_LOGIC;
           selB : in STD_LOGIC;
           Op : in STD_LOGIC_VECTOR (1 downto 0);
           res : out STD_LOGIC_VECTOR(3 downto 0);
           Co : out STD_LOGIC;
           Z: out STD_LOGIC;
           Ov: out STD_LOGIC;
           N: out STD_LOGIC);
end component;

signal A : STD_LOGIC_VECTOR (3 downto 0);
signal B : STD_LOGIC_VECTOR (3 downto 0);
signal selA : STD_LOGIC;
signal selB : STD_LOGIC;
signal Op : STD_LOGIC_VECTOR (1 downto 0);
signal res : STD_LOGIC_VECTOR(3 downto 0);
signal Co : STD_LOGIC;
signal Z: STD_LOGIC;
signal Ov: STD_LOGIC;
signal N: STD_LOGIC;

begin

objeto1: alu4b port map
(
    A => A,
    B => B,
    selA => selA,
    selB => selB,
    Op => Op,
    res => res,
    Co => Co,
    Z => Z,
    Ov => Ov,
    N => N
);

uno: process
begin

    -- A = 5, B = -2
    
    -- A + B
    selA <= '0';
    selB <= '0';
    A <= "0101";
    B <= "1110";
    Op <= "11";
    wait for 50ns;
    
    
    -- A - B
    selA <= '0';
    selB <= '1';
    A <= "0101";
    B <= "1110";
    Op <= "11";
    wait for 50ns;
    
    -- A and B
    selA <= '0';
    selB <= '0';
    A <= "0101";
    B <= "1110";
    Op <= "00";
    wait for 50ns;
    
    -- A nand B
    selA <= '1';
    selB <= '1';
    A <= "0101";
    B <= "1110";
    Op <= "01";
    wait for 50ns;
    
    -- A or B
    selA <= '0';
    selB <= '0';
    A <= "0101";
    B <= "1110";
    Op <= "01";
    wait for 50ns;
    
    -- A nor B
    selA <= '1';
    selB <= '1';
    A <= "0101";
    B <= "1110";
    Op <= "00";
    wait for 50ns;
    
    -- A xor B
    selA <= '0';
    selB <= '0';
    A <= "0101";
    B <= "1110";
    Op <= "10";
    wait for 50ns;
    
    -- A xnor B
    selA <= '1';
    selB <= '0';
    A <= "0101";
    B <= "1110";
    Op <= "10";
    wait for 50ns;
    
    -- A = 5, B = 7
    -- A + B
    selA <= '0';
    selB <= '0';
    A <= "0101";
    B <= "0111";
    Op <= "11";
    wait for 50ns;
    
    -- A = 5, B = 5
    -- A - B
    selA <= '0';
    selB <= '1';
    A <= "0101";
    B <= "0101";
    Op <= "11";
    wait for 50ns;
    
    -- A nand B
    selA <= '1';
    selB <= '1';
    A <= "0101";
    B <= "0101";
    Op <= "01";
    wait for 50ns;
    
end process;

end Behavioral;
