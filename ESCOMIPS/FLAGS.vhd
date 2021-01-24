library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BANDERAS is
    Port(
        CLR, CLK, FL : in STD_LOGIC;
        B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        Q : out STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
end BANDERAS;

architecture A_FLAGS of BANDERAS is

begin
    process(CLK, CLR,FL)
    begin
        if CLR = '1' then
            Q <= (others => '0');
        elsif falling_edge(CLK) and FL = '1' then
            Q <= B;
        end if;
    end process;

end A_FLAGS;
