library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CartaASM is
    Port(
        D : in STD_LOGIC_VECTOR(8 downto 0);
        INI,CLR,CLK : in STD_LOGIC;
        Qa : out STD_LOGIC_VECTOR(8 downto 0);
        DISPLAY : out STD_LOGIC_VECTOR(6 downto 0)
        );
end CartaASM;

architecture A_CartaASM of CartaASM is
    component Reg is
        Port ( 
            Da : in STD_LOGIC_VECTOR (8 downto 0);
            Q : out STD_LOGIC_VECTOR (8 downto 0);
            LA,EA,CLK,CLR : in STD_LOGIC
           );    
    end component;
    component DECO is
        Port(
            TO_DEC : in STD_LOGIC_VECTOR(3 downto 0);
            DISP : out STD_LOGIC_VECTOR(6 downto 0)
            );
    end component;
    component Contador is
        Port(
            LB,EB,CLK,CLR : in STD_LOGIC;
            Qb : out STD_LOGIC_VECTOR(3 DOWNTO 0)
            );
    end component;
    component UC is
        Port(
            CLK,CLR,INI,Z,A0    : in STD_LOGIC;
            LA,LB,EA,EB,EC      : out STD_LOGIC
            );
    end component;
    component C_NOR is
        Port(
            B0 : in STD_LOGIC_VECTOR(8 downto 0);
            A0 : out STD_LOGIC
         );
    end component;
    
    signal B0 : STD_LOGIC_VECTOR(8 downto 0);
    signal B1,B2,B3,B4,B5,B6,B7 : STD_LOGIC;
    signal B8 : STD_LOGIC_VECTOR(3 downto 0);
    signal B9 : STD_LOGIC_VECTOR(6 downto 0);
    
    
begin
    U0 : Reg
        Port map(
            Da => D,
            Q => B0,
            LA => B3,
            EA => B5,
            CLK => CLK,
            CLR => CLR
            );
    U1 : UC
        Port map(
            CLK => CLK,
            CLR => CLR,
            INI => INI,
            Z => B1,
            A0 => B2,
            LA => B3,
            LB => B4,
            EA => B5,
            EB => B6,
            EC => B7
            );
    U2 : Contador
        Port map(
            LB => B4,
            EB => B6,
            CLK => CLK,
            CLR => CLR, 
            Qb => B8
        );
    U3 : DECO
        Port map(
            TO_DEC => B8,
            DISP => B9
            );
    ZERO : C_NOR
        Port map(
            B0 => B0,
            A0 => B1
            );
            
    MUX : process(B7)
        begin
            if B7 = '1' then
                DISPLAY <= B9;
            else
                DISPLAY <= "0000001";
            end if;
        end process;
    
    Qa <= B0;
    B2 <= B0(0);
    
end A_CartaASM;
