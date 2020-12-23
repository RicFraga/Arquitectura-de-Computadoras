library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port(
        CLK,CLR,INI,Z,A0    : in STD_LOGIC;
        LA,LB,EA,EB,EC      : out STD_LOGIC
        );
end UC;

architecture A_UC of UC is
type Estados is (E0,E1,E2);
signal ACT, SIG : Estados;

begin
    STE : process(CLK,CLR)
    begin
        if(CLR = '1') then
            ACT <= E0;
        elsif(rising_edge(CLK)) then
            ACT <= SIG;
        end if;
    end process;
    
    CASM : process(ACT,INI,Z,A0)
    begin
        LA <= '0';
        EA <= '0';
        LB <= '0';
        EB <= '0';
        EC <= '0';
        case ACT is
            when E0 =>
                LB <= '1';
                if(INI = '1') then
                    SIG <= E1;
                else
                    LA <= '1';
                    SIG <= E0;
                end if;
            when E1 =>
                EA <= '1';
                if(Z = '1') then
                    SIG <= E2;
                else
                    if(A0 = '1') then
                        EB <= '1';
                        SIG <= E1;
                    else
                        SIG <= E1;
                    end if;
                end if;
            when E2 =>
                EC <= '1';
                if(INI = '1') then
                    SIG <= E2;
                else
                    SIG <= E0;
                end if;
        end case;
    end process;

end A_UC;
