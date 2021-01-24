library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Regs is
    Port ( writeData : in STD_LOGIC_VECTOR (15 downto 0);
           writeReg  : in STD_LOGIC_VECTOR (3 downto 0);
           readData1 : out STD_LOGIC_VECTOR (15 downto 0);
           readData2 : out STD_LOGIC_VECTOR (15 downto 0);
           readReg1, readReg2: in STD_LOGIC_VECTOR (3 downto 0);
           shamt : in STD_LOGIC_VECTOR (3 downto 0);
           CLK, CLR, SHE, WR, DIR : in STD_LOGIC);
end Regs;

architecture A_Regs of Regs is

--Se definen los componentes que se usaran
component BS is
    Port ( D : in   STD_LOGIC_VECTOR (15 downto 0);
           Q : out  STD_LOGIC_VECTOR (15 downto 0);
           S : in   STD_LOGIC_VECTOR (3 downto 0);
           DIR:in   STD_LOGIC);
end component;
component Reg is
    Port ( D    : in STD_LOGIC_VECTOR (15 downto 0);
           Q    : out STD_LOGIC_VECTOR (15 downto 0);
           L    : in STD_LOGIC;
           CLK  : in STD_LOGIC;
           CLR  : in STD_LOGIC);    
end component;
component DEMUX is
       Port( f : in STD_LOGIC;
             s : in  STD_LOGIC_VECTOR(3 downto 0);
             y : out STD_LOGIC_VECTOR(15 downto 0));
end component;

--Declaración de las señales a usar (buses)
type Bus16 is array (0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal B0 : Bus16;
signal B1 : STD_LOGIC_VECTOR(15 downto 0);
signal B2 : STD_LOGIC_VECTOR(15 downto 0);
signal B3 : STD_LOGIC_VECTOR(15 downto 0);
signal B4 : STD_LOGIC_VECTOR(15 downto 0);
signal B5 : STD_LOGIC_VECTOR(15 downto 0);
        
begin

--Se instancian los registros del 0 al 15 (16 en total)
GEN_REG :       for k in 0 to 15 generate
                    Registros : Reg
                                Port map(
                                D   => B1,
                                Q   => B0(k),
                                L   => B2(k),
                                CLK => CLK,
                                CLR => CLR
                                    );
                end generate;
                
--Se instancia el modulo de Barrel Shifter
BarrelShifter : BS
                Port map(
                    D   => B5,
                    Q   => B4,
                    S   => shamt,
                    DIR => DIR 
                    );
                    
--Se instancia el modulo Demultiplexor de R/W                
WR_DEMUX :  DEMUX
            Port map(
            f => WR,
            s => writeReg,
            y =>B2
            );
            
--Debido a que leer datos no hace caso a ningun estimulo
--que no sea el selector del multiplexor, se hace concurrente
--Multiplexor registro 1
with readReg1 select
       B5 <= B0(15) when x"F",
             B0(14) when x"E",
             B0(13) when x"D",
             B0(12) when x"C",
             B0(11) when x"B",
             B0(10) when x"A",
             B0(9) when x"9",
             B0(8) when x"8",
             B0(7) when x"7",
             B0(6) when x"6",
             B0(5) when x"5",
             B0(4) when x"4",
             B0(3) when x"3",
             B0(2) when x"2",
             B0(1) when x"1",
             B0(0) when others;

--Multiplexor 2
with readReg2 select
        readData2 <= B0(15) when x"F",
                     B0(14) when x"E",
                     B0(13) when x"D",
                     B0(12) when x"C",
                     B0(11) when x"B",
                     B0(10) when x"A",
                     B0(9) when x"9",
                     B0(8) when x"8",
                     B0(7) when x"7",
                     B0(6) when x"6",
                     B0(5) when x"5",
                     B0(4) when x"4",
                     B0(3) when x"3",
                     B0(2) when x"2",
                     B0(1) when x"1",
                     B0(0) when others;

 --Multiplexor 3 se esta haciendo un corrimiento
with SHE select
        B1 <= writeData when '0',
              B4        when others;

readData1 <= B5;
        
end A_Regs;
