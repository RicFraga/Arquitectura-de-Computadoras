
library IEEE;
library STD;
use STD.TEXTIO.ALL;
use IEEE.std_logic_textio.ALL;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use iEEE.std_logic_arith.ALL;

entity tb_pliaprog is
--  Port ( );
end tb_pliaprog;

architecture Behavioral of tb_pliaprog is

component pila_prog is
    Port ( PCin : in STD_LOGIC_VECTOR (15 downto 0);
           WPC : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           UP : in STD_LOGIC;
           DW : in STD_LOGIC;
           PCout : out STD_LOGIC_VECTOR (15 downto 0);
           SPout : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal PCin : STD_LOGIC_VECTOR (15 downto 0);
signal WPC : STD_LOGIC;
signal clk : STD_LOGIC;
signal clr : STD_LOGIC;
signal UP : STD_LOGIC;
signal DW : STD_LOGIC;
signal PCout : STD_LOGIC_VECTOR (15 downto 0);
signal SPout : STD_LOGIC_VECTOR (2 downto 0);

begin

objeto1: pila_prog port map (
    PCin => PCin,
    WPC => WPC,
    clk => clk,
    clr => clr,
    UP => UP,
    DW => DW,
    PCout => PCout,
    SPout => SPout
);

clk_process: process
begin
    clk <= '1';
    wait for 10ns;
    clk <= '0';
    wait for 10ns;
end process;

stim_proc: process

    file ARCH_RES: text;
    variable LINEA_RES: line;
    variable var_PCout: STD_LOGIC_VECTOR(15 downto 0);
    variable var_SPout: STD_LOGIC_VECTOR(2 downto 0);
    
    file ARCH_VEC: text;
    variable LINEA_VEC: line;
    variable var_PCin: STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    variable var_WPC: STD_LOGIC := '0';
    variable var_clr: STD_LOGIC := '0';
    variable var_DW: STD_LOGIC := '0';
    variable var_UP: STD_LOGIC := '0';
    variable aux : integer;

    
    variable cadena: string(1 to 2);
    
    begin
    
        file_open(ARCH_VEC, "/home/fraga/Documents/Pila/entradas.txt", READ_MODE);
        file_open(ARCH_RES, "/home/fraga/Documents/Pila/salida.txt", WRITE_MODE);
        
        cadena := "SP";
        write(LINEA_RES, cadena, right, cadena'length + 3);
        
        cadena := "PC";
        write(LINEA_RES, cadena, right, cadena'length + 3);
        
        writeline(ARCH_RES, LINEA_RES);
    
    --wait for 100ns;
    
    for i in 0 to 100 loop
        
        readline(ARCH_VEC, LINEA_VEC);
        
        Hread(LINEA_VEC, var_PCin);
        PCin <= var_PCin;
        
        read(LINEA_VEC, var_WPC);
        WPC <= var_WPC;
        
        read(LINEA_VEC, var_clr);
        clr <= var_clr;
        
        read(LINEA_VEC, var_UP);
        UP <= var_UP;
        
        read(LINEA_VEC, var_DW);
        DW <= var_DW;
        
        --wait for 10ns;
        wait until rising_edge(clk);
        
        var_PCout := PCout;
        var_SPout := SPout;
        aux := conv_integer(SPout);
        
        write(LINEA_RES, aux, right, 5);
        Hwrite(LINEA_RES, var_PCout, right, 5);        
        
        writeline(ARCH_RES, LINEA_RES);
    
    end loop;
    
    file_close(ARCH_VEC);
    file_close(ARCH_RES);

end process;


end Behavioral;
