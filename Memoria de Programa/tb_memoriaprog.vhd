
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

component memoria_prog is
    Port ( PC : in STD_LOGIC_VECTOR (9 downto 0);
           Inst : out STD_LOGIC_VECTOR (24 downto 0));
end component;

signal PC : STD_LOGIC_VECTOR (9 downto 0);
signal Inst : STD_LOGIC_VECTOR (24 downto 0);

begin

    objeto1 : memoria_prog
        Port map(
        PC=> PC,
        Inst=> Inst
        );
    
    
    stim_proc: process
    
    file ARCH_RES: text;
    variable LINEA_RES: line;
    variable var_Inst: STD_LOGIC_VECTOR(24 downto 0);

    variable var_PC: STD_LOGIC_VECTOR(9 downto 0) := "0000000000";

    variable cadena: string(1 to 6);
    
    begin
        
        file_open(ARCH_RES, "/home/fraga/Memoria de Programa/salidas.txt", WRITE_MODE);
        
        cadena := "  PC  ";
        write(LINEA_RES, cadena, right, cadena'length + 1);
        
        cadena := "OPCODE";
        write(LINEA_RES, cadena, right, cadena'length + 1);
        
        cadena := "19..16";
        write(LINEA_RES, cadena, right, cadena'length + 1);
        
        cadena := "15..12";
        write(LINEA_RES, cadena, right, cadena'length + 1);
        
        cadena := "11...8";
        write(LINEA_RES, cadena, right, cadena'length + 1);
        
        cadena := "7....4";
        write(LINEA_RES, cadena, right, cadena'length + 1);
        
        cadena := "3....0";
        write(LINEA_RES, cadena, right, cadena'length + 1);
        writeline(ARCH_RES, LINEA_RES);
        
        --wait for 1ns;
        
        for i in 0 to 1023 loop
            
            PC <= var_PC;
            wait for 0.1ns;
            var_Inst := Inst;
            
            write(LINEA_RES, conv_integer(var_PC), right, 4);
            write(LINEA_RES, var_Inst(24 downto 20), right, 9);
            write(LINEA_RES, var_Inst(19 downto 16), right, 6);
            write(LINEA_RES, var_Inst(15 downto 12), right, 6);
            write(LINEA_RES, var_Inst(11 downto 8), right, 6);
            write(LINEA_RES, var_Inst(7 downto 4), right, 6);
            write(LINEA_RES, var_Inst(3 downto 0), right, 6);
            
            writeline(ARCH_RES, LINEA_RES);
            var_PC := var_PC + 1;            
            
            wait for 0.1 ns;

        end loop;

        file_close(ARCH_RES); 
    wait;
    end process;
end Behavioral;