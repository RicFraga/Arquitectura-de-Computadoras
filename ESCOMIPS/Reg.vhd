library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
    Port ( D    : in STD_LOGIC_VECTOR (15 downto 0);
           Q    : out STD_LOGIC_VECTOR (15 downto 0);
           L    : in STD_LOGIC;
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC);    
end Reg;

architecture A_Reg of Reg is

begin

    process(CLK, CLR)
    begin
        if (CLR ='1') then
            Q <= (others=>'0');
        elsif rising_edge(CLK) then
            if(L='1') then
                Q <= D;
            end if;
        end if;
    end process;
    
end A_Reg;
