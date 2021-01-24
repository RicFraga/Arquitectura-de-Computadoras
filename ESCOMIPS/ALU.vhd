library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( a,b,cin, sela, selb  : in STD_LOGIC;
           s,cout               : out STD_LOGIC;
           operaciones          : in STD_LOGIC_VECTOR (1 downto 0));
end ALU;

architecture Arq_ALU of ALU is

component Suma1 is
    Port ( 
    a, b, cin   : in STD_LOGIC;
    s, cout     : out STD_LOGIC
    );
end component;

signal op_and, op_or, op_xor, aux_a, aux_b, op_suma : STD_LOGIC;

begin

aux_a   <= a xor sela;
aux_b   <= b xor selb;

op_and  <= aux_a and aux_b;
op_or   <= aux_a or aux_b;
op_xor  <= aux_a xor aux_b;

Comp_Suma1 : Suma1
    Port map( 
    a   => aux_a,
    b   => aux_b,
    cin => cin, 
    s   => op_suma,
    cout=> cout
    );

MUX_G : process(op_and, op_or, op_xor, op_suma, operaciones)
    begin
    
    case operaciones is
        when "00"   =>    s   <=  op_and;
        when "01"   =>    s   <=  op_or;
        when "10"   =>    s   <=  op_xor;
        when others =>    s   <=  op_suma;
    end case;
end process MUX_G;
        
end Arq_ALU;
