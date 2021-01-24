library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NIVEL is
    Port (
        CLK,CLR : in STD_lOGIC;
        NA : out STD_LOGIC
        );
end NIVEL;

architecture A_NIVEL of NIVEL is
signal NCLK, PCLK : STD_LOGIC;

begin
    Alto : process(clk, clr)
    Begin
        if(clr = '1') then
            pclk <= '0';
        elsif(rising_edge(clk)) then
            pclk <= not pclk;
        end if;
    end process;
    Bajo : process(clk, clr)
    Begin
        if(clr = '1') then
            nclk <= '0';
        elsif(falling_edge(clk)) then
            nclk <= not nclk;
        end if;
    end process;

NA <= NCLK xor PCLK;

end A_NIVEL;
