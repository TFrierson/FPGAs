library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register16 is
  Port (
        reg_clk     : in std_logic;
        reg_in      : in std_logic_vector(15 downto 0);
        reg_load    : in std_logic;
        reg_out     : out std_logic_vector(15 downto 0));
end Register16;

architecture Reg16_Dataflow of Register16 is
begin
Reg_Process : process(reg_clk)
begin
    if(rising_edge(reg_clk)) then
        if(reg_load = '1') then
            reg_out <= reg_in;
        end if;
    end if;
end process Reg_Process;

end Reg16_Dataflow;
