library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Or8Way is
  Port (
        Or8_In  : in std_logic_vector(7 downto 0);
        Or8_Out : out std_logic);
end Or8Way;

architecture Or8_Dataflow of Or8Way is

signal or_1, or_2, or_3, or_4, or_5, or_6   : std_logic;
begin
    or_1 <= Or8_in(7) OR Or8_in(6);
    or_2 <= Or8_in(5) OR Or8_in(4);
    or_3 <= Or8_in(3) OR Or8_in(2);
    or_4 <= Or8_in(1) OR Or8_in(0);
    or_5 <= or_1 OR or_2;
    or_6 <= or_3 OR or_4;
    Or8_Out <= or_5 OR or_6;
end Or8_Dataflow;
