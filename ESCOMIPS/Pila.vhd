library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Pila is
    generic (
        n : integer := 3;
        m : integer := 16   
    );
    
    Port(
        PCin : in STD_LOGIC_VECTOR(m-1 downto 0);   
        CLK,CLR,WPC,UP,DW: in STD_LOGIC;
        PCout : out STD_LOGIC_VECTOR(m-1 downto 0); 
        SPout : inout STD_LOGIC_VECTOR(n-1 downto 0) 
    );
end Pila;

architecture A_PILA of Pila is

type contadores is array (0 to (2**n)-1) of STD_LOGIC_VECTOR(m-1 downto 0);

begin

    process(clk, clr)
    variable i : integer := 0;
    variable contador : contadores;  
    begin        
        if(clr = '1') then
            i := 0;
            contador := (others => (others => '0'));            -- Aqui hace un reset a la contador
        elsif(rising_edge(clk)) then
            if(WPC = '0' and UP = '0' and DW = '0') then        -- Aqui hace que el PC incremente de 1 en 1 apuntado por el SP
                contador(i) := contador(i) + 1;
            elsif(WPC = '1' and UP = '0' and DW = '0') then     -- Aqui hace un B (incondicional) o saltos condicionales
                contador(i) := PCin;
            elsif(WPC = '1' and UP = '1' and DW = '0') then     -- Aqui hace un CALL           
                i := i + 1;
                contador(i) := PCin;
            elsif(WPC = '0' and UP = '0' and DW = '1') then     -- Aqui hace un RET
                i := i - 1;
                contador(i) := contador(i) + 1;
            end if;
        end if;
        
        PCout <= contador(i);
        SPout <= conv_std_logic_vector(i,n);
        
    end process; 
    
end A_PILA;