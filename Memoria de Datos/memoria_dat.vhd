
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity memoria_dat is
    Port ( dir : in STD_LOGIC_VECTOR (10 downto 0);
           dataIn : in STD_LOGIC_VECTOR (15 downto 0);
           WD : in STD_LOGIC;
           clk : in STD_LOGIC;
           dataOut : out STD_LOGIC_VECTOR (15 downto 0));
end memoria_dat;

architecture Behavioral of memoria_dat is

type matriz IS ARRAY(0 to 2047) OF STD_LOGIC_VECTOR(15 downto 0);
--signal memoria : matriz := (others => x"0000");
signal memoria: matriz;

begin

process(clk)
begin
    if(rising_edge(clk) and WD = '1') then
        memoria(conv_integer(dir)) <= dataIn;
        
    end if;   
end process;
dataOut <= memoria(conv_integer(dir));

end Behavioral;
