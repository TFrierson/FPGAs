library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is
  Port (
        FA_A        :   in std_logic; 
        FA_B        :   in std_logic;
        Cin         :   in std_logic;
        FA_S        :   out std_logic;
        Cout        :   out std_logic);
end Full_Adder;


architecture FA_Dataflow of Full_Adder is
signal carry_1, carry_2 : std_logic;
signal sum_1            : std_logic;

component Half_Adder
    Port(
         A   :   in std_logic;
         B   :   in std_logic;
         S   :   out std_logic;
         C   :   out std_logic);
end component Half_Adder;

begin
Half_Adder_1    : Half_Adder
    Port Map(
            A => FA_A,
            B => FA_B,
            S => sum_1,
            C => carry_1);

Half_Adder_2    : Half_Adder
    Port Map(
            A => sum_1,
            B => Cin,
            S => FA_S,
            C => carry_2);
            
Cout <= carry_1 OR carry_2;
            
end FA_Dataflow;
