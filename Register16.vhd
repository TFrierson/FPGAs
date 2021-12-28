library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Register16 is
    Port ( Data : in STD_LOGIC_VECTOR (15 downto 0);
           Load : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (15 downto 0));
end Register16;

architecture Behavioral of Register16 is

signal clk_div  : STD_LOGIC_VECTOR(26 downto 0) := (others => '0');
signal cd_clk   : STD_LOGIC;

begin

process(Clk)
begin    
--Slow the main clock (100MHz) to about 1 second. Then feed that clock signal 
--the Register circuit
    if rising_edge(Clk) then
            if clk_div = 50000000 then
                clk_div <= (others => '0');
                cd_clk <= not cd_clk;
            end if;
            clk_div <= clk_div + '1';
    end if;
end process;
    
process(cd_clk,Reset)
begin
    if Reset = '1' then
        Q <= (others => '0');
    elsif rising_edge(cd_clk) then
        if Load = '1' then
            Q <= Data;
        end if;
    end if;
end process;

end Behavioral;
