library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DMux8Way is
  Port (
        DM8_In  : in std_logic; 
        DM8_Sel : in std_logic_vector(2 downto 0);
        DM8_A   : out std_logic;
        DM8_B   : out std_logic;
        DM8_C   : out std_logic;
        DM8_D   : out std_logic;
        DM8_E   : out std_logic;
        DM8_F   : out std_logic;
        DM8_G   : out std_logic;
        DM8_H   : out std_logic);
end DMux8Way;

architecture DMux8_Behavioral of DMux8Way is

begin

DM8_Process : process(DM8_Sel)
begin
    case DM8_Sel is
        when "000" =>
                     DM8_A <= DM8_In;
        when "001" =>
                     DM8_B <= DM8_In;
        when "010" =>
                     DM8_C <= DM8_In;
        when "011" =>
                     DM8_D <= DM8_In;
        when "100" =>
                     DM8_E <= DM8_In;
        when "101" =>
                     DM8_F <= DM8_In;
        when "110" =>
                     DM8_G <= DM8_In;
        when "111" =>
                     DM8_H <= DM8_In;
        when others =>
                     DM8_A <= 'X';
    end case;
                   
end process;

end DMux8_Behavioral;
