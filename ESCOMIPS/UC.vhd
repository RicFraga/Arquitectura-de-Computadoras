library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UC is
    Port(
        FC, FLAGS: in STD_LOGIC_VECTOR(3 DOWNTO 0);
        OPC : in STD_LOGIC_VECTOR(4 DOWNTO 0);
        CLK, CLR: in STD_LOGIC;
        M : out STD_LOGIC_VECTOR(19 DOWNTO 0);
        N : out STD_LOGIC
        );    
end UC;

architecture A_UC of UC is

component OPCODEM is
    Port(
        OPCODE : in STD_LOGIC_VECTOR(4 downto 0);
        MIC : out STD_LOGIC_VECTOR(19 downto 0)
    );
end component;

component MFC is
    Port(
        FUNCODE : in STD_LOGIC_VECTOR(3 downto 0);
        MICRO : out STD_LOGIC_VECTOR(19 downto 0)
    );
end component;

component DECI is
    Port(
        DIR : in STD_LOGIC_VECTOR(4 downto 0);
        ITT : out STD_LOGIC_VECTOR(6 downto 0)
    );
end component;

component CONDICION is
    Port (
        D : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        S : out STD_LOGIC_VECTOR(5 DOWNTO 0)
        );
end component;

component NIVEL is
    Port (
        CLK,CLR : in STD_lOGIC;
        NA : out STD_LOGIC
        );
end component;

component UdC is
    Port(
        DEC : in STD_LOGIC_VECTOR(6 DOWNTO 0);
        COND : in STD_LOGIC_VECTOR(5 DOWNTO 0);
        NA,CLK,CLR : in STD_LOGIC;
        SDOPC, SM : out STD_LOGIC
		);
end component;

component BANDERAS is
    Port(
        CLR, CLK, FL : in STD_LOGIC;
        B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        Q : out STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
end component;

signal B0,B1,B2 : STD_LOGIC_VECTOR(19 DOWNTO 0);
signal B3 : STD_LOGIC_VECTOR(4 DOWNTO 0);
signal B4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
signal B5 : STD_LOGIC_VECTOR(5 DOWNTO 0);
signal B6 : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal NA, SDOPC, SM : STD_LOGIC;

begin
    A0 : OPCODEM
    Port map(
        OPCODE => B3,
        MIC => B2
        );
    A1 : MFC
    Port map(
        FUNCODE => FC,
        MICRO => B0
        );
    A2 : DECI
    Port map(
        DIR => OPC,
        ITT => B4 
        );
    A3 : CONDICION
    Port map(
        D => B6,
        S => B5
        );
    A4 : NIVEL
    Port map(
        CLK => CLK,
        CLR => CLR,
        NA => NA
        );
    A5 : UdC
    Port map(
        DEC => B4,
        COND => B5,
        NA => NA,
        SDOPC => SDOPC,
        SM => SM,
        CLK => CLK,
        CLR => CLR
        );
    A6 : BANDERAS
    Port map(
        CLR => CLR,
        CLK => CLK,
        FL => B1(0),
        B => FLAGS,
        Q => B6
        );

    MUX1 : process(SDOPC,OPC)
    begin
        if SDOPC = '0' then
            B3 <= "00000";
        else
            B3 <= OPC;
        end if;
    end process;
    
    MUX2 : process(SM,B0,B2)
    begin
        if SM = '0' then
            B1 <= B0; --FUNC
        else
            B1 <= B2; --COP
        end if;
    end process;
    
    M <= B1;
    N <= NA;
end A_UC;
