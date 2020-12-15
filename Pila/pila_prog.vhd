
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity pila_prog is
    Port ( PCin : in STD_LOGIC_VECTOR (15 downto 0);
           WPC : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           UP : in STD_LOGIC;
           DW : in STD_LOGIC;
           PCout : out STD_LOGIC_VECTOR (15 downto 0);
           SPout : out STD_LOGIC_VECTOR (2 downto 0));
end pila_prog;

architecture Behavioral of pila_prog is

type arreglo is array(0 to ((2 ** 3) - 1)) of STD_LOGIC_VECTOR(15 downto 0);
signal contadores: arreglo := (others => x"0000");

begin

    process(clk, clr)
    
        variable SP: STD_LOGIC_VECTOR(2 downto 0) := "000";
        variable i: integer := 0;
        
        begin
        i := conv_integer(unsigned(SP));        
        
        if(clr = '1') then
            SP := "000";
            contadores <= (others => (others => '0'));
        
        elsif(rising_edge(clk)) then
            if(WPC = '0' and UP = '0' and DW = '0') then
                contadores(i) <= contadores(i) + 1;
            
            elsif(WPC = '1' and UP = '0' and DW = '0') then
                contadores(i) <= PCin;
            
            elsif(WPC = '1' and UP = '1' and DW = '0') then
                SP := SP + 1;
                i := conv_integer(unsigned(SP));
                contadores(i) <= PCin;
            
            elsif(WPC = '0' and UP = '0' and DW = '1') then
                SP := SP - 1;
                i := conv_integer(unsigned(SP));
                contadores(i) <= contadores(i) + 1;                            
            
            end if;
        
        end if;
        
        PCout <= contadores(i);
        SPout <= SP;
        
    end process;

end Behavioral;
