library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MFC is
    Generic( 
        m : integer := 4;
        n : integer := 20
        );
    Port(
        FUNCODE : in STD_LOGIC_VECTOR(m-1 downto 0);
        MICRO : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
end MFC;

architecture A_MFC of MFC is
TYPE BANCO IS ARRAY (0 to (2**m)-1) of std_logic_vector(n-1 downto 0);       
CONSTANT DEFAULT_MFC : BANCO :=(
    "00001000100000110011", --ADD
    "00001000100001110011", --SUB
    "00001000100000000011", --AND
    "00001000100000010011", --OR
    "00001000100000100011", --XOR
    "00001000100011010011", --NAND
    "00001000100011000011", --NOR
    "00001000100001100011", --XNOR
    "00001000100011000011", --NOT
    "00001010100000000000", --SLL
    "00001011100000000000", --SRL
    others => (others => '0')
    );
    
begin
    MICRO <= DEFAULT_MFC(conv_integer(FUNCODE));
end A_MFC;
