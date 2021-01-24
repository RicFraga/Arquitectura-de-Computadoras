library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ESCOMIPS is
    Port ( 
        INSTRUCCION : out STD_LOGIC_VECTOR(24 downto 0);
        PC,LR1,LR2,R_ALU,BUS_SR : out STD_LOGIC_VECTOR(15 downto 0);
        CLK, CLR : in STD_LOGIC;
        MICRO : out STD_LOGIC_VECTOR(19 downto 0);
        NIVEL : out STD_LOGIC;
        ST : out STD_LOGIC_VECTOR(2 downto 0);
        MEM : out STD_LOGIC_VECTOR(9 downto 0)
        );
end ESCOMIPS;

architecture PROCESADOR of ESCOMIPS is

--UNIDAD DE CONTROL : ENCARGADA DE LIBERAR LAS MICROINSTRUCCIONES
component UC is
    Port(
        FC, FLAGS: in STD_LOGIC_VECTOR(3 DOWNTO 0);
        OPC : in STD_LOGIC_VECTOR(4 DOWNTO 0);
        CLK, CLR : in STD_LOGIC;
        M : out STD_LOGIC_VECTOR(19 DOWNTO 0);
        N : out STD_LOGIC
        );    
end component;
--ARCHIVO DE REGISTROS : EL PROCESADOR GUARDA AQU? LOS DATOS INSTANT?NEOS
component Regs is
    Port ( 
        writeData : in STD_LOGIC_VECTOR (15 downto 0);
        writeReg  : in STD_LOGIC_VECTOR (3 downto 0);
        readData1 : out STD_LOGIC_VECTOR (15 downto 0);
        readData2 : out STD_LOGIC_VECTOR (15 downto 0);
        readReg1, readReg2: in STD_LOGIC_VECTOR (3 downto 0);
        shamt : in STD_LOGIC_VECTOR (3 downto 0);
        CLK, CLR, SHE, WR, DIR : in STD_LOGIC);
end component;
--ALU : MODULO ENCARGADO DE HACER LAS OPERACIONES DISPONIBLES
component ALUN is
    Port ( a,b      : in STD_LOGIC_VECTOR(15 downto 0);
           opera    : in STD_LOGIC_VECTOR(3 downto 0); 
           res      : out STD_LOGIC_VECTOR(15 downto 0);
           N,C,OV   : out STD_LOGIC;
           Z        : out STD_LOGIC
           );
end component;
--MEMORIA DE DATOS : UNIDAD QUE ALMACENA DATOS 
component MD is
    Port( 
        add :   in STD_LOGIC_VECTOR(9 downto 0);
        dataIn :in STD_LOGIC_VECTOR(15 downto 0);
        WD,CLK :in STD_LOGIC;
        dataOut:out STD_LOGIC_VECTOR(15 downto 0)
        );
end component;
--MEMORIA DE PROGRAMA : UNIDAD QUE ALMACENA EL PROGRAMA PREDETERMINADO
component MP is
    Port(
        DIR : in STD_LOGIC_VECTOR(9 downto 0);
        ITT : out STD_LOGIC_VECTOR(24 downto 0)
        );
end component;
--PILA DEL PROCESADOR : ELEMENTO ENCARGADO PARA LAS SUBRUTINAS Y EL PC
component Pila iS 
    Port(
        PCin : in STD_LOGIC_VECTOR(15 downto 0);   
        CLK,CLR,WPC,UP,DW: in STD_LOGIC;
        PCout : out STD_LOGIC_VECTOR(15 downto 0); 
        SPout : inout STD_LOGIC_VECTOR(2 downto 0) 
        );
end component;
--EXTENSORES DE SIGNO : ALGUNAS INSTRUCCIONES TIENEN LITERALES DE 12 Y SE HACE COMPATIBLE CON ALU
component EXTS is
   Port(
        LIT : in STD_LOGIC_VECTOR(11 downto 0);
        LE : out STD_LOGIC_VECTOR(15 downto 0) 
        );
end component;
--EXTENSION DE DIRECCION: EN ESTE BLOQUE SE HACE COMPATIBLE LA DIRECCI?N CON LA ALU
component EXTD is
    Port(
        DIR : in STD_LOGIC_VECTOR(11 downto 0);
        DE : out STD_LOGIC_VECTOR(15 downto 0) 
        );
end component;

signal B10 : STD_LOGIC_VECTOR(9 downto 0);
signal B2,B6 : STD_LOGIC_VECTOR(3 downto 0);
signal B0,B1,B3,B4,B5,B7,B8,B9,B11,B12,B13,B14,B15,B16 : STD_LOGIC_VECTOR(15 downto 0);

signal SP : STD_LOGIC_VECTOR(2 downto 0);
signal BA : STD_LOGIC;
signal BM : STD_LOGIC_VECTOR(19 downto 0);
signal BI : STD_LOGIC_VECTOR(24 downto 0);

begin

    STACK : Pila
    Port map(
        PCin => B0,
        CLK => CLK,
        CLR => CLR,
        WPC => BM(17),
        UP => BM(19),
        DW => BM(18),
        PCout => B1, 
        SPout => SP
        );
        
    MPROG : MP
    Port map(
        DIR => B1(9 downto 0),
        ITT => BI
        );
    
    AREG : REGS
    Port map(
        writeData => B3,
        writeReg => BI(19 downto 16),
        readData1 => B4,
        readData2 => B5,
        readReg1 => BI(15 downto 12),
        readReg2 => B2,
        shamt => BI(7 downto 4),
        CLK => CLK,
        CLR => CLR,
        SHE => BM(13),
        WR => BM(11),
        DIR => BM(12)
        );
    ALU : ALUN
    Port map(
        a => B7,
        b => B8,
        opera => BM(7 downto 4), 
        res => B9,
        N =>B6(0),
        C =>B6(1),
        OV =>B6(3),
        Z =>B6(2)
        );
        
    CONTROL : UC
    Port map( 
        FC => BI(3 downto 0),
        FLAGS => B6,
        OPC => BI(24 downto 20),
        CLK => CLK,
        CLR => CLR,
        M => BM,
        N => BA
        ); 
        
    MDATA : MD
    Port map( 
        add => B10,
        dataIn => B5,
        WD=> BM(2),
        CLK => CLK,
        dataOut => B11
        );
        
    ES : EXTS 
    Port map(
        LIT => BI(11 downto 0),
        LE => B14
        );
    
    ED : EXTD
    Port map(
        DIR => BI(11 downto 0),
        DE => B15
        );
    
    SR2 : process(BI,BM)
    begin
    if BM(14) = '0' then
        B2 <= BI(11 downto 8);
    else
        B2 <= BI(19 downto 16);
    end if;
    end process;

    SOP1 : process(B4,B1,BM)
    begin
    if BM(8) = '0' then
        B7 <= B4;
    else
        B7 <= B1; 
    end if;
    end process;
    
    SOP2 : process(B5,B12,BM)
    begin
    if BM(9) = '0' then
        B8 <= B5;
    else
        B8 <= B12;
    end if;
    end process;
    
    SDMD : process(B9,BI,BM)
    begin
    if BM(3) = '0' then
        B10 <= B9(9 downto 0);
    else
        B10 <= BI(9 downto 0);
    end if;
    end process;
    
    SR : process(B11,B9,BM)
    begin
    if BM(1) = '0' then
        B13 <= B11;
    else
        B13 <= B9;
    end if;
    end process;
    
    SDMP : process(BI,B13,BM)
    begin
    if BM(16) = '0' then
        B0 <= BI(15 downto 0);
    else
        B0 <= B13;
    end if;
    end process;
    
    SWD : process(B13,BI,BM)
    begin
    if BM(15) = '0' then
        B3 <= BI(15 downto 0);
    else
        B3 <= B13;
    end if;
    end process;
    
    SEXT : process(B14,B15,BM)
    begin
    if BM(10) = '0' then
        B12 <= B14;
    else
        B12 <= B15;
    end if;
    end process;
    
    PC <= B1;
    INSTRUCCION <= BI;
    LR1 <= B4;
    LR2 <= B5;
    BUS_SR <= B13;
    R_ALU <= B9;
    MICRO <= BM;
    NIVEL <= BA;
    ST <= SP;
    MEM <= B10;
    
end PROCESADOR;
