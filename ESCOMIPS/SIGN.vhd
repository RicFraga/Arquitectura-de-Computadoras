library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EXTS is
    Port(
        LIT : in STD_LOGIC_VECTOR(11 downto 0);
        LE : out STD_LOGIC_VECTOR(15 downto 0) 
        );
end EXTS;

architecture A_EXTS of EXTS is
begin
    process(LIT)
    begin
    if LIT(11) = '0' then
        LE <= "0000" & LIT;
    else
        LE <= "1111" & LIT;
    end if;
    end process;
    
end A_EXTS;
