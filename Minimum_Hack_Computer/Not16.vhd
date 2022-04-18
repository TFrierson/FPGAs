library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Not_16 is
  Port (
        Not16_In    : in std_logic_vector(15 downto 0);
        Not16_Out   : out std_logic_vector(15 downto 0) );
end Not_16;

architecture Not_Dataflow of Not_16 is

begin
Not16_Out(0) <= NOT Not16_In(0);
Not16_Out(1) <= NOT Not16_In(1);
Not16_Out(2) <= NOT Not16_In(2);
Not16_Out(3) <= NOT Not16_In(3);
Not16_Out(4) <= NOT Not16_In(4);
Not16_Out(5) <= NOT Not16_In(5);
Not16_Out(6) <= NOT Not16_In(6);
Not16_Out(7) <= NOT Not16_In(7);
Not16_Out(8) <= NOT Not16_In(8);
Not16_Out(9) <= NOT Not16_In(9);
Not16_Out(10) <= NOT Not16_In(10);
Not16_Out(11) <= NOT Not16_In(11);
Not16_Out(12) <= NOT Not16_In(12);
Not16_Out(13) <= NOT Not16_In(13);
Not16_Out(14) <= NOT Not16_In(14);
Not16_Out(15) <= NOT Not16_In(15);
end Not_Dataflow;
