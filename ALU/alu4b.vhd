
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu4b is
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
end alu4b;

architecture Behavioral of alu4b is

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

signal C: STD_LOGIC_VECTOR(3 downto 0);
signal R: STD_LOGIC_VECTOR(3 downto 0);

begin

--ciclo: for i in 0 to 3 generate
        
        u0: alu1b
        Port map(
           A => A(0),
           B => B(0),
           selA => selA,
           selB => selB,
           Cin => selB,
           Op => Op,
           Cout => C(0),
           res => R(0));
           
        u1: alu1b
        Port map(
           A => A(1),
           B => B(1),
           selA => selA,
           selB => selB,
           Cin => C(0),
           Op => Op,
           Cout => C(1),
           res => R(1));
        
        u2: alu1b
        Port map(
           A => A(2),
           B => B(2),
           selA => selA,
           selB => selB,
           Cin => C(1),
           Op => Op,
           Cout => C(2),
           res => R(2));
           
        
        u3: alu1b
        Port map(
           A => A(3),
           B => B(3),
           selA => selA,
           selB => selB,
           Cin => C(2),
           Op => Op,
           Cout => C(3),
           res => R(3));
           
       -- Resultado
       res <= R;
       Co <= C(3);
       
       -- Banderas
       Z <= not(R(0) or R(1) or R(2) or R(3));
       N <= R(3);
       Ov <= C(3) xor C(2);
       
  --     end generate;
       
end Behavioral;
