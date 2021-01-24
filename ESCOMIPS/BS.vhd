library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity BS is
    Port ( D : in   STD_LOGIC_VECTOR (15 downto 0);
           Q : out  STD_LOGIC_VECTOR (15 downto 0);
           S : in   STD_LOGIC_VECTOR (3 downto 0);
           DIR:in   STD_LOGIC);
end BS;

architecture A_BS of BS is

begin
    process(D,S, DIR)
        variable aux : STD_LOGIC_VECTOR(15 downto 0);
        begin
            aux := D;
            if DIR = '1' then
                for i in 0 to 3 loop
                    for j in 15 downto 2**i loop
                        if S(i) = '0' then
                            aux(j) := aux(j);
                        else
                            aux(j) := aux(j-2**i);
                        end if;
                    end loop;
                    for j in 2**i-1 downto 0 loop
                        if S(i) = '0' then
                            aux(j) := aux(j);
                        else
                            aux(j) := '0';
                        end if;
                    end loop;
                end loop;
            else
                for i in 0 to 3 loop
                    for j in 0 to 15- 2**i loop
                        if S(i) = '0' then
                            aux(j) := aux(j);
                        else
                            aux(j) := aux(j+2**i);
                        end if;
                    end loop;
                    for j in 15-2**i+1 to 15  loop
                        if S(i) = '0' then
                            aux(j) := aux(j);
                        else
                            aux(j) := '0';
                        end if;
                    end loop;
                end loop;
            end if;
            Q <= aux;
        end process;
end A_BS;
