library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C_NOR is
    Port(
        B0 : in STD_LOGIC_VECTOR(8 downto 0);
        A0 : out STD_LOGIC
         );
end C_NOR;

architecture A_NOR of C_NOR is
    signal AZ: STD_LOGIC_VECTOR(8 downto 0);
    signal A : STD_LOGIC;

begin

    AZ(0) <= B0(0);
    
    ZEROS: 
    for l in 1 to 8 generate
        AZ(l) <= AZ(l-1) or B0(l);
    end generate;
    
    A <= AZ(8);
    A0 <= not A;
    
end A_NOR;
