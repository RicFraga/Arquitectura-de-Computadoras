library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MP is
    generic( 
        m : integer := 10;
        n : integer := 25;
        i : integer := 25; -- NUMERO DE ELEMENTOS EN ARREGLO DE BUUBLE SORT
        AD : integer := 15;  -- ORIENTACIÓN DE ARREGLO : 17 = ASC, 15 =DESC
        q : integer := 0; --NUMERO POR EL QUE EMPIEZA A LLENAR EL ARREGLO
        w : integer := 29;
        e : integer := 36
        );
    Port(
        DIR : in STD_LOGIC_VECTOR(m-1 downto 0);
        ITT : out STD_LOGIC_VECTOR(n-1 downto 0)
    );
end MP;

architecture A_TP of MP is

TYPE CO IS ARRAY (0 TO 23) OF STD_lOGIC_VECTOR(4 DOWNTO 0);
TYPE REG IS ARRAY (0 TO 15) OF STD_lOGIC_VECTOR(3 DOWNTO 0);
TYPE COR IS ARRAY (0 TO 10) OF STD_lOGIC_VECTOR(3 DOWNTO 0);

CONSTANT R : REG := (x"0",x"1",x"2",x"3",x"4",x"5",x"6",x"7",x"8",x"9",x"A",x"B",x"C",x"D",x"E",x"F");
CONSTANT COP : CO := ("00000","00001","00010","00011","00100","00101","00110","00111",
                      "01000","01001","01010","01011","01100","01101","01110","01111",
                      "10000","10001","10010","10011","10100","10101","10110","10111");
CONSTANT SU : STD_LOGIC_VECTOR(3 downto 0) := "0000";
CONSTANT CR : COR := (x"0",x"1",x"2",x"3",x"4",x"5",x"6",x"7",x"8",x"9",x"A");
CONSTANT J : STD_LOGIC_VECTOR(15 downto 0) := conv_std_logic_vector(i,16);
---
CONSTANT A : STD_LOGIC_VECTOR(15 downto 0) := conv_std_logic_vector(q,16);
CONSTANT B : STD_LOGIC_VECTOR(15 downto 0) := conv_std_logic_vector(w,16);
CONSTANT C : STD_LOGIC_VECTOR(15 downto 0) := conv_std_logic_vector(e,16);
---      
TYPE BANCO IS ARRAY (0 to (2**m)-1) of std_logic_vector(n-1 downto 0);       
CONSTANT DEFAULT_PROGRAM : BANCO :=(
  
    --BUBBLE SORT

    --MAIN
    COP(20) & SU & x"0005", --0        
    COP(20) & SU & x"000E", --1          
    COP(20) & SU & x"0021", --2       
    COP(22) & SU & SU & SU & SU & SU, --3
    COP(19) & SU & x"0002", --4
    --RELLENA 
    COP(1) & R(0) & x"0000", --5
    COP(1) & R(1) & J, --6
    COP(1) & R(2) & A, --7
    COP(15) & R(1) & R(0) & x"002", --8
    COP(21) & SU & SU & SU & SU & SU, --9
    COP(4) & R(2) & R(0) & x"000", --10
    COP(5) & R(0) & R(0) & x"001", --11
    COP(5) & R(2) & R(2) & x"002", --12
    COP(19) & SU & x"0008", --13
    --Ordena DESC
    COP(1) & R(3) & x"0000",--14
    COP(6) & R(4) & R(1) & x"001",--15
    COP(15) & R(4) & R(3) & x"002",--16
    COP(21) & SU & SU & SU & SU & SU,--17
    COP(1) & R(5) & x"0000",--18
        COP(0) & R(6) & R(1) & R(3) & SU & CR(1),--19
        COP(6) & R(6) & R(6) & x"001",--20
        COP(15) & R(6) & R(5) & x"003",--21
        COP(5) & R(3) & R(3) & x"001",--22
        COP(19) & SU & x"0010",--23
            COP(23) & R(7) & R(5) & x"000",--24
            COP(23) & R(8) & R(5) & x"001",--25
            COP(AD) & R(8) & R(7) & x"003",--26
            COP(5) & R(5) & R(5) & x"001",--27
            COP(19) & SU & x"0015",--28
            COP(5) & R(9) & R(7) & x"000",--29
            COP(4) & R(8) & R(5) & x"000",--30
            COP(4) & R(9) & R(5) & x"001",--31
            COP(19) & SU & x"001B",--32 
    --MUESTRA
    COP(1) & R(0) & x"0000",--33
    COP(1) & R(1) & J,--34
    COP(15) & R(1) & R(0) & x"002",--35
    COP(21) & SU & SU & SU & SU & SU,--36
    COP(23) & R(7) & R(0) & x"000",--37
    COP(0) & R(15) & R(0) & R(7) & SU & CR(0),--38
    COP(5) & R(0) & R(0) & x"001",--39
    COP(19) & SU & x"0023",--40

--      --Menor de 3 numeros
--      COP(1) & R(0) & A,--0
--      COP(1) & R(1) & B,--1
--      COP(1) & R(2) & C,--2
--      COP(15) & R(0) & R(1) & x"003",--3
--      COP(5) & R(3) & R(0) & x"000",--4
--      COP(19) & SU & x"0007",--5
--      COP(5) & R(3) & R(1) & X"000",--6
--      COP(16) & R(2) & R(3) & x"003",--7
--      COP(5) & R(4) & R(2) & x"000",--8
--      COP(19) & SU & x"000B",--9
--      COP(5) & R(4) & R(3) & x"000",--10
--      COP(19) & SU & x"000B",--11 
      
--    --PRUEBA SUMA Y GUARDA MEMORIA
--    COP(1) & R(0) & x"0001",--0
--    COP(1) & R(1) & x"0007",--1
--    COP(0) & R(1) & R(1) & R(0) & SU & CR(0),--2
--    COP(3) & R(1) & x"0005", --3
----    COP(2) & R(2) & x"0005",--4
----    COP(0) & R(3) & R(1) & R(2) & SU & CR(0),--5
--    COP(19) & SU & x"0002",--6

--    --PROGRAMA ASIGNADO
--    COP(1) & R(0) & x"0037",--0
--    COP(1) & R(1) & x"000A",--1
--    COP(1) & R(2) & x"0000",--2
    
--    COP(4) & R(0) & R(2) & x"000",--3
    
--    COP(5) & R(2) & R(2) & x"001",--4
--    COP(6) & R(0) & R(0) & x"002",--5
    
--    COP(14) & R(1) & R(2) & x"FFD",--6
    
--    COP(2) & R(4) & X"0000",--7
--    COP(2) & R(5) & X"0001",---8
--    COP(2) & R(6) & X"0002",--9
--    COP(2) & R(7) & X"0003",--10
--    COP(2) & R(8) & X"0004",--11
--    COP(2) & R(9) & X"0005",--12
--    COP(2) & R(10) & X"0006",--13
--    COP(2) & R(11) & X"0007",--14
--    COP(2) & R(12) & X"0008",--15
--    COP(2) & R(13) & X"0009",--16
    
--    COP(0) & R(3) & R(4) & R(5) & SU & CR(0),--17
--    COP(0) & R(3) & R(6) & R(7) & SU & CR(0),--18
--    COP(0) & R(3) & R(8) & R(9) & SU & CR(0),--19
--    COP(0) & R(3) & R(10) & R(11) & SU & CR(0),--20
--    COP(0) & R(3) & R(12) & R(13) & SU & CR(0),--21
    
--    COP(22) & SU & SU & SU & SU & SU,--7--22
--    COP(19) & SU & x"0007",--8--23
    
    others => (others => '0')
    );
    
begin
ITT<= DEFAULT_PROGRAM(conv_integer(DIR));
end A_TP;
