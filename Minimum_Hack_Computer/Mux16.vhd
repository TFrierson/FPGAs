library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux16 is
  Port (
        Mux16_A     : in std_logic_vector(15 downto 0);
        Mux16_B     : in std_logic_vector(15 downto 0);
        Mux16_Sel   : in std_logic;
        Mux16_Out   : out std_logic_vector(15 downto 0));
end Mux16;

architecture Mux16_Dataflow of Mux16 is

begin

    with Mux16_Sel select
        Mux16_Out <= Mux16_A when '0',
                     Mux16_B when '1',
                     "XXXXXXXXXXXXXXXX" when others;
end Mux16_Dataflow;
