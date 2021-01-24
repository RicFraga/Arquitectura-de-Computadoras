library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DECI is
    Generic( 
        m : integer := 5;
        n : integer := 7
        );
    Port(
        DIR : in STD_LOGIC_VECTOR(m-1 downto 0);
        ITT : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
end DECI;

architecture A_DECI of DECI is
signal i : integer := 1;
begin
    i <= conv_integer(DIR);
    process(i)
    begin
        if i = 0 then
            ITT <= "1000000";
        elsif (i > 0 and i < 13) then
            ITT <= "0000000";
        elsif i = 13 then
            ITT <= "0100000";
        elsif i = 14 then
            ITT <= "0010000";
        elsif i = 15 then
            ITT <= "0001000";
        elsif i = 16 then
            ITT <= "0000100";
        elsif i = 17 then
            ITT <= "0000010";
        elsif i = 18 then
            ITT <= "0000001";
        else
            ITT <= "0000000";
        end if;
    end process;

end A_DECI;
