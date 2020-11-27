
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity aregistro is
    Port ( writeReg : in STD_LOGIC_VECTOR (3 downto 0);
           writeData : in STD_LOGIC_VECTOR (15 downto 0);
           readReg1 : in STD_LOGIC_VECTOR (3 downto 0);
           readReg2 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           shamt : in STD_LOGIC_VECTOR (3 downto 0);
           clr : in STD_LOGIC;
           WR : in STD_LOGIC;
           SHE : in STD_LOGIC;
           DIR : in STD_LOGIC;
           readData1 : out STD_LOGIC_VECTOR (15 downto 0);
           readData2 : out STD_LOGIC_VECTOR (15 downto 0));
end aregistro;

architecture Behavioral of aregistro is

type matriz IS ARRAY(0 to 7) OF STD_LOGIC_VECTOR(15 downto 0);
signal registros : matriz;
signal registros_b: bit_vector(15 downto 0);

begin

process(clr, clk, WR, SHE, DIR)
begin
    
    -- Operación de clear    
    if(clr = '1') then
        for i in 0 to 7 loop
            registros(i) <= x"0000";
        end loop;
    
    elsif(rising_edge(clk)) then
        
        -- Retención
        if(WR = '0' and SHE = '0' and DIR = '0') then
             registros <= registros;
        
        -- Carga
        elsif(WR = '1' and SHE = '0') then
            registros(conv_integer(writeReg)) <= writeData;
        
        -- Desplazamiento a la derecha >>
        elsif(WR = '1' and SHE = '1' and DIR = '0') then
            registros_b <= to_bitvector(registros(conv_integer(readReg2))) srl conv_integer(shamt);
            registros(conv_integer(writeReg)) <= to_stdlogicvector(registros_b);
        
        -- -- Desplazamiento a la izquierda <<
        elsif(WR = '1' and SHE = '1' and DIR = '1') then
            registros_b <= to_bitvector(registros(conv_integer(readReg2))) sll conv_integer(shamt);
            registros(conv_integer(writeReg)) <= to_stdlogicvector(registros_b);
        
        end if;     
    end if;
    
    readData1 <= registros(conv_integer(readReg1));
    readData2 <= registros(conv_integer(readReg2));
    
end process;

end Behavioral;