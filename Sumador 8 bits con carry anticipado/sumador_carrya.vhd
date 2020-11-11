
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sumador_carrya is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Cout : out STD_LOGIC);
end sumador_carrya;

architecture Behavioral of sumador_carrya is

begin

process (A, B)
    variable P, G: STD_LOGIC_VECTOR(7 downto 0);
    variable C: STD_LOGIC_VECTOR(8 downto 0);
    variable aux, aux2: STD_LOGIC;
    
    begin
    
    -- Primer término
    C(0) := '0';
    P(0) := A(0) xor B(0);
    G(0) := A(0) and B(0);
    S(0) <= P(0) xor C(0);
    C(1) := (C(0) and P(0)) or G(0);
    
    -- Resto de términos dentro del loop
    for i in 1 to 7 loop
        
        P(i) := A(i) xor B(i);
        G(i) := A(i) and B(i);
        
        -- Cálculo del acarreo
        
        -- Primera parte
        aux := C(0);
        for j in 0 to i loop
            aux := aux and P(j);
            
        end loop;
        
        -- Segunda parte
        for k in 0 to i - 1 loop
        aux2 := G(k);
            for l in k + 1 to i loop
                aux2 := aux2 and P(l);
            end loop;
        end loop;
        
        -- Todo junto
        C(i+1) := aux or aux2 or G(i);
        
        -- Calculo de la salida en i
        S(i) <= P(i) xor C(i);    
        
        end loop;
        
        Cout <= C(8);

end process;

end Behavioral;