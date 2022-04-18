library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Incrementer is
  Port (
        Incr_In : in std_logic_vector(15 downto 0);
        Incr_Out : out std_logic_vector(15 downto 0));
end Incrementer;

architecture Incr_Structural of Incrementer is

component Adder16 is
    Port (
        Adder16_A   : in std_logic_vector(15 downto 0);
        Adder16_B   : in std_logic_vector(15 downto 0);
        Adder16_Out : out std_logic_vector(15 downto 0));
end component Adder16;
 
begin
    
Incr_Adder : Adder16
    Port Map(
            Adder16_A => Incr_In,
            Adder16_B => "0000000000000001",
            Adder16_Out => Incr_Out);
end Incr_Structural;
