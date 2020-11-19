
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu1b is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           selA : in STD_LOGIC;
           selB : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Op : in STD_LOGIC_VECTOR (1 downto 0);
           Cout : out STD_LOGIC;
           res : out STD_LOGIC);
end alu1b;

architecture Behavioral of alu1b is

-- Señales auxiliares
signal auxA: std_logic;
signal auxB: std_logic;

begin

-- Con qué valores de las entradas vamos a trabajar
-- (No negados o negados)
auxA <= A xor selA;
auxB <= B xor selB;

res <= auxA and auxB when Op = "00" else
       auxA or auxB when Op = "01" else
       auxA xor auxB when Op = "10" else
       auxA xor auxB xor Cin;

-- Bit de acarreo (únicamente tiene sentido en operaciones aritméticas)
Cout <= (auxA and Cin) or (auxB and Cin) or (auxA and auxB);

end Behavioral;