
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumador_restador is
    Port ( a, b : in STD_LOGIC_VECTOR (7 downto 0);
           Co : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Ca: out STD_LOGIC);
end sumador_restador;

architecture Behavioral of sumador_restador is

signal E_b : STD_LOGIC_VECTOR(7 downto 0);
signal C: STD_LOGIC_VECTOR(8 downto 0);

begin
    
    C(0) <= Co;
    bucle: for i in 0 to 7 generate
        
        E_b(i) <= b(i) xor C(0);
        S(i) <= a(i) xor E_b(i) xor C(i);
        C(i+1) <= (a(i) and C(i)) or (a(i) and E_b(i)) or (E_b(i) and C(i));
        
    end generate;
    
    Ca <= C(8); 

end Behavioral;
