library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TDECO is end TDECO;

architecture TB of TDECO is
    component DECO is
        Port(
            TO_DEC : in STD_LOGIC_VECTOR(3 downto 0);
            DISP : out STD_LOGIC_VECTOR(6 downto 0)
            );
    end component;

signal B0 : STD_LOGIC_VECTOR(3 downto 0);
signal B1 : STD_LOGIC_VECTOR(6 downto 0);

begin
    U3 : DECO
        Port map(
            TO_DEC => B0,
            DISP => B1
            );
    process
    variable i : integer range 0 to 9;
    begin
        while true loop
            B0 <= conv_std_logic_vector(i,4);
            wait for 10 ns;
            i := i + 1;
        end loop;
    end process;
end TB;
