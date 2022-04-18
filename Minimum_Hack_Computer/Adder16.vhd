library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder16 is
  Port (
        Adder16_A   : in std_logic_vector(15 downto 0);
        Adder16_B   : in std_logic_vector(15 downto 0);
        Adder16_Out : out std_logic_vector(15 downto 0));
end Adder16;

architecture Adder16_Dataflow of Adder16 is

component Half_Adder is
    Port (
        A   : in std_logic;
        B   : in std_logic;
        S   : out std_logic;
        C   : out std_logic);
end component Half_Adder;

component Full_Adder is
    Port (
        FA_A        :   in std_logic; 
        FA_B        :   in std_logic;
        Cin         :   in std_logic;
        FA_S        :   out std_logic;
        Cout        :   out std_logic);
end component Full_Adder;

signal carry_0, carry_1, carry_2, carry_3, carry_4, carry_5, carry_6, carry_7 : std_logic;
signal carry_8, carry_9, carry_10, carry_11, carry_12, carry_13, carry_14     : std_logic;
begin

Half_Adder_0 : Half_Adder
    Port Map(
            A => Adder16_A(0),
            B => Adder16_B(0),
            S => Adder16_Out(0),
            C => carry_0);
            
Full_Adder_0 : Full_Adder
    Port Map(
            FA_A => Adder16_A(1),
            FA_B => Adder16_B(1),
            Cin => carry_0,
            FA_S => Adder16_Out(1),
            Cout => carry_1);
            
Full_Adder_1 : Full_Adder
    Port Map(
            FA_A => Adder16_A(2),
            FA_B => Adder16_B(2),
            Cin => carry_1,
            FA_S => Adder16_Out(2),
            Cout => carry_2);
            
Full_Adder_2 : Full_Adder
    Port Map(
            FA_A => Adder16_A(3),
            FA_B => Adder16_B(3),
            Cin => carry_2,
            FA_S => Adder16_Out(3),
            Cout => carry_3);

Full_Adder_3 : Full_Adder
    Port Map(
            FA_A => Adder16_A(4),
            FA_B => Adder16_B(4),
            Cin => carry_3,
            FA_S => Adder16_Out(4),
            Cout => carry_4);
            
Full_Adder_4 : Full_Adder
    Port Map(
            FA_A => Adder16_A(5),
            FA_B => Adder16_B(5),
            Cin => carry_4,
            FA_S => Adder16_Out(5),
            Cout => carry_5);
            
Full_Adder_5 : Full_Adder
    Port Map(
            FA_A => Adder16_A(6),
            FA_B => Adder16_B(6),
            Cin => carry_5,
            FA_S => Adder16_Out(6),
            Cout => carry_6);
            
Full_Adder_6 : Full_Adder
    Port Map(
            FA_A => Adder16_A(7),
            FA_B => Adder16_B(7),
            Cin => carry_6,
            FA_S => Adder16_Out(7),
            Cout => carry_7);


Full_Adder_7 : Full_Adder
    Port Map(
            FA_A => Adder16_A(8),
            FA_B => Adder16_B(8),
            Cin => carry_7,
            FA_S => Adder16_Out(8),
            Cout => carry_8);
            
Full_Adder_8 : Full_Adder
    Port Map(
            FA_A => Adder16_A(9),
            FA_B => Adder16_B(9),
            Cin => carry_8,
            FA_S => Adder16_Out(9),
            Cout => carry_9);
            
Full_Adder_9 : Full_Adder
    Port Map(
            FA_A => Adder16_A(10),
            FA_B => Adder16_B(10),
            Cin => carry_9,
            FA_S => Adder16_Out(10),
            Cout => carry_10);
            
Full_Adder_10 : Full_Adder
    Port Map(
            FA_A => Adder16_A(11),
            FA_B => Adder16_B(11),
            Cin => carry_10,
            FA_S => Adder16_Out(11),
            Cout => carry_11);
            
Full_Adder_11 : Full_Adder
    Port Map(
            FA_A => Adder16_A(12),
            FA_B => Adder16_B(12),
            Cin => carry_11,
            FA_S => Adder16_Out(12),
            Cout => carry_12);
            
Full_Adder_12 : Full_Adder
    Port Map(
            FA_A => Adder16_A(13),
            FA_B => Adder16_B(13),
            Cin => carry_12,
            FA_S => Adder16_Out(13),
            Cout => carry_13);
            
Full_Adder_13 : Full_Adder
    Port Map(
            FA_A => Adder16_A(14),
            FA_B => Adder16_B(14),
            Cin => carry_13,
            FA_S => Adder16_Out(14),
            Cout => carry_14);
            
Full_Adder_14 : Full_Adder
    Port Map(
            FA_A => Adder16_A(15),
            FA_B => Adder16_B(15),
            Cin => carry_14,
            FA_S => Adder16_Out(15),
            Cout => open);
end Adder16_Dataflow;
