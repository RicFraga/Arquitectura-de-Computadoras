library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UdC is
    Port(
        DEC : in STD_LOGIC_VECTOR(6 DOWNTO 0);
        COND : in STD_LOGIC_VECTOR(5 DOWNTO 0);
        NA, CLK,CLR : in STD_LOGIC;
        SDOPC, SM : out STD_LOGIC
		);
end UdC;

architecture A_UDC of UdC is
type ESTADOS is (E0);
signal EA,ES : ESTADOS;

begin
    STE : process(CLK,CLR)
    begin
        if(CLR = '1') then
            EA <= E0;
        elsif(rising_edge(CLK)) then
            EA <= ES;
        end if;
    end process;
    
    CARTA : process(DEC,COND,NA,EA)
    begin
        SDOPC <= '0';
        SM <= '0';
        case EA is
            when E0 => ES <= E0;
            if DEC(6) = '0' then --TIPOR
                if DEC(5) = '1' then -- BEQI
                    if NA = '1' then
                        SM <= '1';
                    else
                        if COND(5) = '0' then 
                            SM <= '1';
                        else
                            SDOPC <= '1';
                            SM <= '1';
                        end if;
                    end if;
                elsif DEC(4) = '1' then --BNEQI
                    if NA = '1' then
                        SM <= '1';
                    else
                        if COND(4) = '0' then 
                            SM <= '1';
                        else
                            SDOPC <= '1';
                            SM <= '1';
                        end if;
                    end if;
                elsif DEC(3) = '1' then --BLTI
                    if NA = '1' then
                        SM <= '1';
                    else
                        if COND(3) = '0' then 
                            SM <= '1';
                        else
                            SDOPC <= '1';
                            SM <= '1';
                        end if;
                    end if;
                elsif DEC(2) = '1' then --BLETI
                    if NA = '1' then
                        SM <= '1';
                    else
                        if COND(2) = '0' then 
                            SM <= '1';
                        else
                            SDOPC <= '1';
                            SM <= '1';
                        end if;
                    end if;
                elsif DEC(1) = '1' then --BGTI
                    if NA = '1' then
                        SM <= '1';
                    else
                        if COND(1) = '0' then 
                            SM <= '1';
                        else
                            SDOPC <= '1';
                            SM <= '1';
                        end if;
                    end if;
                elsif DEC(0) = '1' then --BGETI
                    if NA = '1' then
                        SM <= '1';
                    else
                        if COND(0) = '0' then 
                            SM <= '1';
                        else
                            SDOPC <= '1';
                            SM <= '1';
                        end if;
                    end if;
                else -- Distinto de R y saltos condicionales 
                    SDOPC <= '1';
                    SM <= '1';
                end if;                  
            end if;
       end case;
   end process;
end A_UDC;
