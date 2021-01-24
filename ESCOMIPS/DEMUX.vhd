library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEMUX is
       Port( f : in STD_LOGIC;
             s : in  STD_LOGIC_VECTOR(3 downto 0);
             y : out STD_LOGIC_VECTOR(15 downto 0));
end DEMUX;

architecture A_DEMUX of DEMUX is

begin
    y(0)<=f when s="0000"else'0';
    y(1)<=f when s="0001"else'0';
    y(2)<=f when s="0010"else'0';
    y(3)<=f when s="0011"else'0';
    y(4)<=f when s="0100"else'0';
    y(5)<=f when s="0101"else'0';
    y(6)<=f when s="0110"else'0';
    y(7)<=f when s="0111"else'0';
    y(8)<=f when s="1000"else'0';
    y(9)<=f when s="1001"else'0';
    y(10)<=f when s="1010"else'0';
    y(11)<=f when s="1011"else'0';
    y(12)<=f when s="1100"else'0';
    y(13)<=f when s="1101"else'0';
    y(14)<=f when s="1110"else'0';
    y(15)<=f when s="1111"else'0';
        
end A_DEMUX;
