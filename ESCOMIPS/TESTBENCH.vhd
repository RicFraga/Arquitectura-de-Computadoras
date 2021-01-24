library IEEE;
library STD;

use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;

entity TESTBENCH is
end TESTBENCH;

architecture TEST of TESTBENCH is

component ESCOMIPS is
    Port ( 
        INSTRUCCION : out STD_LOGIC_VECTOR(24 downto 0);
        PC, LR1,LR2,R_ALU,BUS_SR : out STD_LOGIC_VECTOR(15 downto 0);
        CLK, CLR : in STD_LOGIC;
        MICRO : out STD_LOGIC_VECTOR(19 downto 0);
        NIVEL : out STD_LOGIC;
        ST : out STD_LOGIC_VECTOR(2 downto 0);
        MEM : out STD_LOGIC_VECTOR(9 downto 0)
        );
end component;

signal INSTRUCCION : STD_LOGIC_VECTOR(24 downto 0);
signal PC : STD_LOGIC_VECTOR(15 downto 0);
signal LR1,LR2,R_ALU,BUS_SR : STD_LOGIC_VECTOR(15 downto 0);
signal CLK, N : STD_LOGIC;
signal CLR : STD_LOGIC:= '1';
signal RCLR : STD_LOGIC;
signal MICRO : STD_LOGIC_VECTOR(19 downto 0);
signal ST : STD_LOGIC_VECTOR(2 downto 0);
signal MEM : STD_LOGIC_VECTOR(9 downto 0);

---------------------------------------------------------------------------------------------------------------------------------
--TYPE CO IS ARRAY (0 TO 23) OF STRING(1 TO 5);
--CONSTANT OPCODE : CO := ("ADD  ","LI   ","LWI  ","SWI  ","SW   ","ADDI ","SUBI ","ANDI ",
--                         "ORI  ","XORI ","NANDI","NORI ","XNORI","BEQI ","BNEI ","BLTI ",
--                         "BLETI","BGTI ","BGETI","B    ","CALL ","RET  ","NOP  ","LW   "
--                        );
                                             
--TYPE COR IS ARRAY (0 TO 10) OF STRING(1 TO 5);
--CONSTANT RCODE : COR := ("ADD  ","SUB  ","AND  ","OR   ","XOR  ",
--                         "NAND ","NOR  ","XNOR ","NOT  ","SLL  ","SRL  "
--                        );
                    
--TYPE REG IS ARRAY (0 TO 15) OF STRING(1 TO 3);
--CONSTANT NUMREG : REG := ("R0 ","R1 ","R2 ","R3 ","R4 ","R5 ","R6 ","R7 ","R8 ","R9 ","R10","R11","R12","R13","R14","R15");
------------------------------------------------------------------------------------------------------------------------------------

begin
    PROCESADOR : ESCOMIPS
    Port map(
        PC => PC,
        INSTRUCCION => INSTRUCCION,
        LR1 => LR1,
        LR2 => LR2,
        R_ALU => R_ALU,
        BUS_SR => BUS_SR,
        CLK => CLK,
        CLR => CLR,
        MICRO => MICRO,
        NIVEL => N,
        ST => ST,
        MEM => MEM
        );
    
    RELOJ : process
    begin
        CLK <= '0';
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
    end process;
    
    CLEAR : process
    begin
        RCLR <= '1';
        wait for 3 ns;
        RCLR <= '0';
        wait;
    end process;
    
    ASSERTCLR : process(RCLR,CLK)
    begin
        if falling_edge(CLK) then
            CLR <= RCLR;
        end if;
    end process;
    
--    process
--        file SALIDAS : TEXT;
--        variable LINEA : LINE;
--        variable NI : STD_LOGIC_VECTOR(15 downto 0);
--        variable INST : STD_LOGIC_VECTOR(24 downto 0);
--        variable NO: integer;
--        variable TR: integer;
--        variable Rd : integer;
--        variable Rt : integer;
--        variable Rs : integer;
--        variable BS : integer;
        
--        variable A : STRING(1 to 2) := "PC";
--        variable B : STRING(1 to 11) := "INSTRUCCION";
--        variable C : STRING(1 to 3) := "RD1";
--        variable D : STRING(1 to 3) := "RD2";
--        variable E : STRING(1 to 3) := "ALU";
--        variable F : STRING(1 to 2) := "SR";
--        variable G : STRING(1 to 2) := "Tn";
--        variable H : STRING(1 to 1) := "T";
        
--        variable j : integer := 0;
--    begin
--        file_open(SALIDAS, "C:\Users\ernes\Desktop\Arq\ESCOMIPS\RESULTADO.TXT", WRITE_MODE);
--        write(LINEA,G,left,4);
--        write(LINEA,A,left,4);
--        write(LINEA,B,left,25);
--        write(LINEA,C,left,6);
--        write(LINEA,D,left,6);
--        write(LINEA,E,left,6);
--        write(LINEA,F,left,6);
--        writeline(SALIDAS,LINEA);
--        WHILE TRUE LOOP
--        INST := INSTRUCCION;
--        NI := PC;
--        write(LINEA,H,left,1);
--        write(LINEA,J,LEFT,3);
--            write(LINEA,conv_integer(unsigned(NI)),left,4);
--            NO := conv_integer(unsigned(INST(24 downto 20)));
--            IF NO = 0 then
--                --Tipo R
--                TR := conv_integer(unsigned(INST(3 downto 0)));
--                write(LINEA,RCODE(TR),left,6);
--                --RD
--                Rd := conv_integer(unsigned(INST(19 downto 16)));
--                write(LINEA,NUMREG(Rd),left,4);
--                --RT
--                Rt := conv_integer(unsigned(INST(15 downto 12)));
--                write(LINEA,NUMREG(Rt),left,4);
--                --Si son de Corrimiento
--                BS := conv_integer(unsigned(INST(3 downto 0)));
--                IF  BS >= 9 then
--                    write(LINEA,INST(7 downto 4),left,11);
--                ELSE --No son de Corrimiento
--                    Rs := conv_integer(unsigned(INST(11 downto 8)));
--                    write(LINEA,NUMREG(Rs),left,11);
--                END IF;
--            ELSIF NO>= 1 AND NO <= 3 then
--                --Operaci?n
--                write(LINEA,OPCODE(NO),left,6);
--                --RD
--                Rd := conv_integer(unsigned(INST(19 downto 16)));
--                write(LINEA,NUMREG(Rd),left,4);
--                --lit
--                IF NO = 1 THEN
--                    write(LINEA,conv_integer(signed(INST(15 downto 0))),left,15);
--                ELSE
--                    write(LINEA,conv_integer(unsigned(INST(15 downto 0))),left,15);
--                END IF;
--            ELSIF NO >= 19 AND NO <= 20 then
--                --Operaci?n
--                write(LINEA,OPCODE(NO),left,6);
--                --lit
--                write(LINEA,conv_integer(unsigned(INST(15 downto 0))),left,19);
--            ELSIF NO >= 21 AND NO <= 22 then
--                --Operaci?n
--                write(LINEA,OPCODE(NO),left,25);
--            ELSE
--                --Operaci?n
--                write(LINEA,OPCODE(NO),left,6);
--                --RD
--                Rd := conv_integer(unsigned(INST(19 downto 16)));
--                write(LINEA,NUMREG(Rd),left,4);
--                --RT
--                Rt := conv_integer(unsigned(INST(15 downto 12)));
--                write(LINEA,NUMREG(Rt),left,4);
--                --lit
--                IF NO = 4 OR (NO >= 7 AND NO <= 12) OR NO = 23 THEN
--                    write(LINEA,conv_integer(unsigned(INST(11 downto 0))),left,11);
--                ELSE
--                    write(LINEA,conv_integer(signed(INST(11 downto 0))),left,11);
--                END IF;
--            END IF;
            
--            write(LINEA,conv_integer(signed(LR1)),left,6);
--            write(LINEA,conv_integer(signed(LR2)),left,6);
--            write(LINEA,conv_integer(signed(R_ALU)),left,6);
--            write(LINEA,conv_integer(signed(BUS_SR)),left,6);
--            writeline(SALIDAS,LINEA);
--            J := J + 1;
--            wait until rising_edge(CLK);
--        END LOOP;
        
--        file_close(SALIDAS);
--    end process;
    
end TEST;
