library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Contador is
    Port(
        LB,EB,CLK,CLR : in STD_LOGIC;
        Qb : out STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
end Contador;

architecture A_Contador of Contador is

signal Db: integer := 0;
signal D : integer range 0 to 9;

begin
    process(CLK,CLR)
    
    begin
        if CLR = '1' then
            D <= 0;
        elsif rising_edge(CLK) then
            if LB = '0' and EB = '0' then
                D <= D;
            elsif LB = '1' and EB = '0' then
                D <= Db;
            elsif LB = '0' and EB ='1' then
                D <= D + 1;
            end if;
        end if;
    end process;
    
Qb <= conv_std_logic_vector(D,4);

end A_Contador;
