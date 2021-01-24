library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONDICION is
    Port (
        D : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        S : out STD_LOGIC_VECTOR(5 DOWNTO 0)
        );
end CONDICION;

architecture A_COND of CONDICION is
    
begin
    S(5) <= D(2); 
    S(4) <= NOT D(2); 
    S(3) <= NOT D(1);
    S(2) <= D(2) OR (NOT D(1));
    S(1) <= (NOT D(2)) AND D(1);
    S(0) <= D(1);
    
end A_COND;