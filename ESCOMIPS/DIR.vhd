library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EXTD is
    Port(
        DIR : in STD_LOGIC_VECTOR(11 downto 0);
        DE : out STD_LOGIC_VECTOR(15 downto 0) 
        );
end EXTD;

architecture A_EXTD of EXTD is

begin
    DE <= "0000" & DIR;
end A_EXTD;
