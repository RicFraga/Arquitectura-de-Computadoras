library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUN is
    generic( i      : integer := 16 );
    Port ( a,b      : in STD_LOGIC_VECTOR(i-1 downto 0);
           opera    : in STD_LOGIC_VECTOR(3 downto 0); 
           res      : out STD_LOGIC_VECTOR(i-1 downto 0);
           N,C,OV   : out STD_LOGIC;
           Z        : out STD_LOGIC
           );
end ALUN;

architecture Arq_ALUG of ALUN is

component ALU is
    Port ( a,b,cin, sela, selb: in STD_LOGIC;
           s,cout : out STD_LOGIC;
           operaciones : in STD_LOGIC_VECTOR (1 downto 0));
end component;

signal Acarreos : STD_LOGIC_VECTOR(i downto 0);
signal aux_res  : STD_LOGIC_VECTOR(i-1 downto 0);
signal aux_Z    : STD_LOGIC_VECTOR(i-1 downto 0);
signal z_p      : STD_LOGIC;
signal b_suma   : STD_LOGIC;

begin
    
    Acarreos(0) <= opera(2);
    b_suma      <= opera(1) and opera(0);
        
    GENERA : for k in 0 to i-1 generate
        ALUbits : ALU
            Port map(
                a   => a(k),
                b   => b(k),
                cin => Acarreos(k),
                sela=> opera(3),
                selb=> opera(2),
                s   => aux_res(k),
                cout=> Acarreos(k+1),
                operaciones =>  opera(1 downto 0)
            );
    end generate;
    
    --Calcula OR´s
    aux_Z(0)    <= aux_res(0);
    gen : for l in 1 to i-1 generate
        aux_Z(l) <= aux_Z(l-1) or aux_res(l);
    end generate;
    
    z_p <= aux_Z(i-1);
    
    --Banderas
    C   <= Acarreos(i) and b_suma;
    N   <= aux_res(i-1);
    OV  <= (Acarreos(i) xor Acarreos(i-1)) and b_suma;
    Z   <= not z_p;
    
    res <= aux_res;
    
     
end Arq_ALUG;
