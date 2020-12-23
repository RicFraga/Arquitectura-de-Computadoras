library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECO is
    Port(
        TO_DEC : in STD_LOGIC_VECTOR(3 downto 0);
        DISP : out STD_LOGIC_VECTOR(6 downto 0)
        );
end DECO;

architecture A_DECO of DECO is
constant DIG0 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111110";
constant DIG1 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000";
constant DIG2 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1101101";
constant DIG3 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111001";
constant DIG4 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110011";
constant DIG5 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1011011";
constant DIG6 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1011111";
constant DIG7 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1110000";
constant DIG8 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
constant DIG9 : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111011";

begin
    BCD : process(TO_DEC)
    begin
        case TO_DEC is
            when "0001" => DISP <= DIG1;
            when "0010" => DISP <= DIG2;
            when "0011" => DISP <= DIG3;
            when "0100" => DISP <= DIG4;
            when "0101" => DISP <= DIG5;
            when "0110" => DISP <= DIG6;
            when "0111" => DISP <= DIG7;
            when "1000" => DISP <= DIG8;
            when "1001" => DISP <= DIG9;
            when others => DISP <= DIG0;
        end case;
    end process;          
end A_DECO;
