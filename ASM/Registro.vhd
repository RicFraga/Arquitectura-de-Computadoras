library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg is
    Port ( Da : in STD_LOGIC_VECTOR (8 downto 0);
           Q : out STD_LOGIC_VECTOR (8 downto 0);
           LA,EA,CLK,CLR : in STD_LOGIC
           );    
end Reg;

architecture A_Reg of Reg is
signal D : STD_LOGIC_VECTOR(8 downto 0) := "000000000";

begin

    process(CLK, CLR)
    begin
        if CLR ='1' then
            D <= (others=>'0');
        elsif rising_edge(CLK) then
            if LA = '0' and EA = '0' then
                D <= D;
            elsif LA = '0' and EA = '1' then
                D(7 downto 0) <= D(8 downto 1);
                D(8) <= '0';
            elsif LA = '1' and EA = '0' then
                D <= Da;
            end if;
        end if;
    end process;
   
Q <= D;
    
end A_Reg;
