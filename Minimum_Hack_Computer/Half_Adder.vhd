library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Half_Adder is
  Port (
        A   : in std_logic;
        B   : in std_logic;
        S   : out std_logic;
        C   : out std_logic);
end Half_Adder;

architecture HA_DataFlow of Half_Adder is

begin
    S <= A XOR B;
    C <= A AND B;
    
end HA_DataFlow;
