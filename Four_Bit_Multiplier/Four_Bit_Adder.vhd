library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Four_Bit_Adder is
Generic(
        data_width  : integer := 4);
  Port (
        FBA_A       : in std_logic_vector(data_width - 1 downto 0);
        FBA_B       : in std_logic_vector(data_width - 1 downto 0);
        FBA_S       : out std_logic_vector(data_width - 1 downto 0);
        FBA_Cout    : out std_logic);
end Four_Bit_Adder;

architecture FBA_Structural of Four_Bit_Adder is
component Half_Adder is
    Port(
        A   : in std_logic;
        B   : in std_logic;
        S   : out std_logic;
        C   : out std_logic);
end component Half_Adder;

component Full_Adder is
    Port(
        FA_A        :   in std_logic; 
        FA_B        :   in std_logic;
        Cin         :   in std_logic;
        FA_S        :   out std_logic;
        Cout        :   out std_logic);
end component Full_Adder;

signal carry_0, carry_1, carry_2    : std_logic;
signal sum_1, sum_2, sum_3          : std_logic;

begin

    Half_Adder_0 : Half_Adder
        Port Map(
                A => FBA_A(0),
                B => FBA_B(0),
                S => FBA_S(0),
                C => carry_0);
                
    Full_Adder_0 : Full_Adder
        Port Map(
                FA_A => FBA_A(1),
                FA_B => FBA_B(1),
                Cin => carry_0,
                FA_S => FBA_S(1),
                Cout => carry_1);
                
    Full_Adder_1 : Full_Adder
        Port Map(
                FA_A => FBA_A(2),
                FA_B => FBA_B(2),
                Cin => carry_1,
                FA_S => FBA_S(2),
                Cout => carry_2);
                
    Full_Adder_2 : Full_Adder
        Port Map(
                FA_A => FBA_A(3),
                FA_B => FBA_B(3),
                Cin => carry_2,
                FA_S => FBA_S(3),
                Cout => FBA_Cout);  
end FBA_Structural;
