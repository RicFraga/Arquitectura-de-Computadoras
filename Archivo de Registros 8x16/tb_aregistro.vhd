
library IEEE;
library STD;
use STD.TEXTIO.ALL;
use IEEE.std_logic_textio.ALL;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use iEEE.std_logic_arith.ALL;

entity tb_aregistro is
--  Port ( );
end tb_aregistro;

architecture Behavioral of tb_aregistro is

component aregistro is
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
end component;

signal writeReg : STD_LOGIC_VECTOR (3 downto 0);
signal writeData : STD_LOGIC_VECTOR (15 downto 0);
signal readReg1 : STD_LOGIC_VECTOR (3 downto 0);
signal readReg2 : STD_LOGIC_VECTOR (3 downto 0);
signal clk : STD_LOGIC;
signal shamt : STD_LOGIC_VECTOR (3 downto 0);
signal clr : STD_LOGIC;
signal WR : STD_LOGIC;
signal SHE : STD_LOGIC;
signal DIR : STD_LOGIC;
signal readData1 : STD_LOGIC_VECTOR (15 downto 0);
signal readData2 : STD_LOGIC_VECTOR (15 downto 0);

begin

objeto1: aregistro port map (
    writeReg => writeReg,
    writeData => writeData,
    readReg1 => readReg1,
    readReg2 => readReg2,
    clk => clk,
    shamt => shamt,
    clr => clr,
    WR => WR,
    SHE => SHE,
    DIR => DIR, 
    readData1 => readData1,
    readData2 => readData2
);

clk_process: process
begin
    clk <= '0';
    wait for 10ns;
    clk <= '1';
    wait for 10ns;
end process;

stim_proc: process

file ARCH_RES: text;
variable LINEA_RES: line;
variable var_readData1: STD_LOGIC_VECTOR(15 downto 0);
variable var_readData2: STD_LOGIC_VECTOR(15 downto 0);

file ARCH_VEC: text;
variable LINEA_VEC: line;
variable var_writeReg: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
variable var_writeData: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
variable var_readReg1: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
variable var_readReg2: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
variable var_shamt: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
variable var_clr: STD_LOGIC := '0';
variable var_WR: STD_LOGIC := '0';
variable var_SHE: STD_LOGIC := '0';
variable var_DIR: STD_LOGIC := '0';
variable cadena: string(1 to 5);

begin
    file_open(ARCH_VEC, "/home/fraga/Documents/Archivo de Registros/VECTORES.txt", READ_MODE);
    file_open(ARCH_RES, "/home/fraga/Documents/Archivo de Registros/RESULTADOS.txt", WRITE_MODE);
    
    cadena := "  RR1";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "  RR2";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "SHAMT";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := " WREG";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "   WD";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "   WR";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "  SHE";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "  DIR";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "  RD1";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "  RD2";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    writeline(ARCH_RES, LINEA_RES);
    
    wait for 100ns;
    
    for i in 0 to 11 loop
        
        readline(ARCH_VEC, LINEA_VEC);
        
        read(LINEA_VEC, var_WR);
        WR <= var_WR;
        
        read(LINEA_VEC, var_SHE);
        SHE <= var_SHE;
        
        read(LINEA_VEC, var_DIR);
        DIR <= var_DIR;
        
        Hread(LINEA_VEC, var_writeReg);
        writeReg <= var_writeReg;
        
        Hread(LINEA_VEC, var_writeData);
        writeData <= var_writeData;
        
        Hread(LINEA_VEC, var_readReg1);
        readReg1 <= var_readReg1;
        
        Hread(LINEA_VEC, var_readReg2);
        readReg2 <= var_readReg2;
        
        Hread(LINEA_VEC, var_shamt);
        shamt <= var_shamt;
        
        read(LINEA_VEC, var_clr);
        clr <= var_clr;
        
        wait until rising_edge(clk);
        
        var_readData1 := readData1;
        var_readData2 := readData2;
        
        Hwrite(LINEA_RES, var_readReg1, right, 5);
        Hwrite(LINEA_RES, var_readReg2, right, 5);
        Hwrite(LINEA_RES, var_shamt, right, 5);
        Hwrite(LINEA_RES, var_writeReg, right, 5);
        Hwrite(LINEA_RES, var_writeData, right, 5);
        write(LINEA_RES, var_WR, right, 5);
        write(LINEA_RES, var_SHE, right, 5);
        write(LINEA_RES, var_DIR, right, 5);
        Hwrite(LINEA_RES, var_readData1, right, 5);
        Hwrite(LINEA_RES, var_readData2, right, 5);
        
        writeline(ARCH_RES, LINEA_RES);
    end loop;
    
    file_close(ARCH_VEC);
    file_close(ARCH_RES);
    
    wait;

end process;

end Behavioral;
