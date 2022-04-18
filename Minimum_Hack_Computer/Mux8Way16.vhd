library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux8Way16 is
  Port (
        Mux8_A      : in std_logic_vector(15 downto 0);
        Mux8_B      : in std_logic_vector(15 downto 0);
        Mux8_C      : in std_logic_vector(15 downto 0);
        Mux8_D      : in std_logic_vector(15 downto 0);
        Mux8_E      : in std_logic_vector(15 downto 0);
        Mux8_F      : in std_logic_vector(15 downto 0);
        Mux8_G      : in std_logic_vector(15 downto 0);
        Mux8_H      : in std_logic_vector(15 downto 0);
        Mux8_Sel    : in std_logic_vector(2 downto 0);
        Mux8_Out    : out std_logic_vector(15 downto 0));
end Mux8Way16;

architecture Mux8_Behavioral of Mux8Way16 is

begin
Mux8_Process : Process(Mux8_Sel)
begin
    case Mux8_Sel is
        when "000" =>
                    Mux8_Out <= Mux8_A;
        when "001" =>
                    Mux8_Out <= Mux8_B;
        when "010" =>
                    Mux8_Out <= Mux8_C;
        when "011" =>
                    Mux8_Out <= Mux8_D;
        when "100" =>
                    Mux8_Out <= Mux8_E;
        when "101" =>
                    Mux8_Out <= Mux8_F;
        when "110" =>
                    Mux8_Out <= Mux8_G;
        when "111" =>
                    Mux8_Out <= Mux8_H;
        when others =>
                    Mux8_Out <= "XXXXXXXXXXXXXXXX";            
                   
    end case;
end process;

end Mux8_Behavioral;
