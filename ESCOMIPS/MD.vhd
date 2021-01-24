library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MD is
        generic(m : integer := 10;
                n : integer := 16
                );
        Port( 
            add :   in STD_LOGIC_VECTOR(m-1 downto 0);
            dataIn :in STD_LOGIC_VECTOR(n-1 downto 0);
            WD,CLK :in STD_LOGIC;
            dataOut:out STD_LOGIC_VECTOR(n-1 downto 0)
        );
end MD;

architecture A_MD of MD is

type banco is array (0 to (2**m)-1) of STD_LOGIC_VECTOR(n-1 downto 0);
signal B0 : banco := (others => (others => '0'));

begin
    process(CLK)
    begin
        if(rising_edge(CLK)) then
            if(WD = '1') then
                B0(conv_integer(add)) <= dataIn;
            end if;
        end if;
    end process;
    
dataOut <= B0(conv_integer(add));
                
end A_MD;
