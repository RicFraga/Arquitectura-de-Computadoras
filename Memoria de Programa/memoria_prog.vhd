
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memoria_prog is
    generic (
        m : integer := 10;
        n : integer := 25
    );
    
    Port ( PC : in STD_LOGIC_VECTOR (m - 1 downto 0);
           Inst : out STD_LOGIC_VECTOR (n - 1 downto 0));
end memoria_prog;

architecture Behavioral of memoria_prog is

type Mem is array(0 to ((2**m) - 1)) of STD_LOGIC_VECTOR(n - 1 downto 0);
type a_OP is array(0 to 23) of STD_LOGIC_VECTOR(4 downto 0);
type a_R is array(0 to 15) of STD_LOGIC_VECTOR(3 downto 0);

constant OP: a_OP := ("00000","00001","00010","00011","00100","00101","00110","00111",
                      "01000","01001","01010","01011","01100","01101","01110","01111",
                      "10000","10001","10010","10011","10100","10101","10110","10111");

CONSTANT R : a_R := (x"0",x"1",x"2",x"3",x"4",x"5",x"6",x"7",x"8",x"9",x"A",x"B",x"C",x"D",x"E",x"F");

CONSTANT programa: Mem := (
    
    -- R0 = 0
    OP(1) & R(0) & x"0000",
    
    -- R1 = 1
    OP(1) & R(1) & x"0001",
    
    -- R2 = 0
    OP(1) & R(2) & x"0000",
    
    -- R3 = 12
    OP(1) & R(3) & x"000C",
    
    -- R4 = R0 + R1
    OP(0) & R(4) & R(0) & R(1) & x"00",
    
    -- mem[72] = R4
    OP(3) & R(4) & x"0072",
    
    -- R0 = R1
    OP(5) & R(0) & R(1) & x"000",
    
    -- R1 = R4
    OP(5) & R(1) & R(4) & x"000",
    
    -- R2 = R2 + 1
    OP(5) & R(2) & R(2) & x"001",
    
    -- R2 != R3
    OP(14) & R(3) & R(2) & x"004",
    
    -- NOP
    OP(22) & x"00000",
    
    -- B NOp
    OP(19) & x"0" & x"000A",
    
    others => (others => '0')
);

begin

Inst <= programa(conv_integer(PC));

end Behavioral;
