library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Suma1 is
    Port ( 
    a, b, cin   : in STD_LOGIC;
    s, cout     : out STD_LOGIC
    );
end Suma1;

architecture Suma1_Arq of Suma1 is

begin
    s   <= a xor b xor cin;
    cout<= (a and b) or (a and cin) or (b and cin);

end Suma1_Arq;
