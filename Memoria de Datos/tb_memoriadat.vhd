
library IEEE;
library STD;
use STD.TEXTIO.ALL;
use IEEE.std_logic_textio.ALL;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use iEEE.std_logic_arith.ALL;

entity tb_memoriaprog is
--  Port ( );
end tb_memoriaprog;

architecture Behavioral of tb_memoriaprog is

component memoria_dat is
    Port ( dir : in STD_LOGIC_VECTOR (10 downto 0);
           dataIn : in STD_LOGIC_VECTOR (15 downto 0);
           WD : in STD_LOGIC;
           clk : in STD_LOGIC;
           dataOut : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal dir : STD_LOGIC_VECTOR (10 downto 0);
signal dataIn : STD_LOGIC_VECTOR (15 downto 0);
signal WD : STD_LOGIC;
signal clk : STD_LOGIC;
signal dataOut : STD_LOGIC_VECTOR (15 downto 0);

begin

objeto1: memoria_dat port map (
    dir => dir,
    dataIn => dataIn,
    WD => WD,
    clk => clk,
    dataOut => dataOut
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
variable var_dataOut: STD_LOGIC_VECTOR(15 downto 0);

file ARCH_VEC: text;
variable LINEA_VEC: line;
variable var_WD: STD_LOGIC := '0';
variable var_dir: STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
variable var_dataIn: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

variable cadena: string(1 to 7);

begin
    file_open(ARCH_VEC, "/home/fraga/Documents/Memoria de Programa/entradas.txt", READ_MODE);
    file_open(ARCH_RES, "/home/fraga/Documents/Memoria de Programa/salidas.txt", WRITE_MODE);
    
    cadena := " add   ";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "    WD ";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := " dataIn";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    
    cadena := "dataOut";
    write(LINEA_RES, cadena, right, cadena'length + 1);
    writeline(ARCH_RES, LINEA_RES);
    
    wait for 130ns;
    
    for i in 0 to 11 loop
        
        readline(ARCH_VEC, LINEA_VEC);
        
        read(LINEA_VEC, var_WD);
        WD <= var_WD;
        
        Hread(LINEA_VEC, var_dir);
        dir <= var_dir;
        
        Hread(LINEA_VEC, var_dataIn);
        dataIn <= var_dataIn;
        
        --wait until rising_edge(clk);
        
        var_dataOut := dataOut;
        
        wait until rising_edge(clk);
        
        Hwrite(LINEA_RES, var_dir, right, 5);
        write(LINEA_RES, WD, right, 10);
        Hwrite(LINEA_RES, var_dataIn, right, 8);
        Hwrite(LINEA_RES, var_dataOut, right, 8);
        
        writeline(ARCH_RES, LINEA_RES);
    end loop;
    
    file_close(ARCH_VEC);
    file_close(ARCH_RES);
    
    wait;
end process;

end Behavioral;
