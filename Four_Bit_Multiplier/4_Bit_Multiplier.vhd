library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Four_Bit_Multiplier is
Generic(
        data_width  : integer := 4);
  Port (
        multiplicand    : in std_logic_vector(data_width - 1 downto 0);
        multiplier      : in std_logic_vector(data_width - 1 downto 0);
        product         : out std_logic_vector(7 downto 0));
end Four_Bit_Multiplier;


architecture FBM_Structural of Four_Bit_Multiplier is

component Four_Bit_Adder
    Port(
        FBA_A       : in std_logic_vector(3 downto 0);
        FBA_B       : in std_logic_vector(3 downto 0);
        FBA_S       : out std_logic_vector(3 downto 0);
        FBA_Cout    : out std_logic);
end component Four_Bit_Adder;

--b = multiplicand, a = multiplier
signal b0a0, b0a1, b0a2, b0a3, b1a0, b1a1, b1a2, b1a3, b2a0, b2a1, b2a2, b2a3, b3a0, b3a1, b3a2, b3a3   : std_logic;
signal sum_0, sum_1                                                                                     : std_logic_vector(2 downto 0);
signal carry_0, carry_1, carry2                                                                         : std_logic;

begin
        b0a0 <= multiplicand(0) AND multiplier(0);
        b0a1 <= multiplicand(0) AND multiplier(1);
        b0a2 <= multiplicand(0) AND multiplier(2);
        b0a3 <= multiplicand(0) AND multiplier(3);
        
        b1a0 <= multiplicand(1) AND multiplier(0);
        b1a1 <= multiplicand(1) AND multiplier(1);
        b1a2 <= multiplicand(1) AND multiplier(2);
        b1a3 <= multiplicand(1) AND multiplier(3);
        
        b2a0 <= multiplicand(2) AND multiplier(0);
        b2a1 <= multiplicand(2) AND multiplier(1);
        b2a2 <= multiplicand(2) AND multiplier(2);
        b2a3 <= multiplicand(2) AND multiplier(3);
        
        b3a0 <= multiplicand(3) AND multiplier(0);
        b3a1 <= multiplicand(3) AND multiplier(1);
        b3a2 <= multiplicand(3) AND multiplier(2);
        b3a3 <= multiplicand(3) AND multiplier(3);
        
        product(0) <= b0a0;
        
        Four_Bit_Adder_0 : Four_Bit_Adder
            Port Map(
                    FBA_A(0) => b0a1,
                    FBA_A(1) => b0a2,
                    FBA_A(2) => b0a3,
                    FBA_A(3) => '0',
                    FBA_B(0) => b1a0,
                    FBA_B(1) => b1a1,
                    FBA_B(2) => b1a2,
                    FBA_B(3) => b1a3,
                    FBA_S(0) => product(1),
                    FBA_S(1) => sum_0(0),
                    FBA_S(2) => sum_0(1),
                    FBA_S(3) => sum_0(2),
                    FBA_Cout => carry_0);
                    
        Four_Bit_Adder_1 : Four_Bit_Adder
            Port Map(
                    FBA_A(0) => sum_0(0),
                    FBA_A(1) => sum_0(1),
                    FBA_A(2) => sum_0(2),
                    FBA_A(3) => carry_0,
                    FBA_B(0) => b2a0,
                    FBA_B(1) => b2a1,
                    FBA_B(2) => b2a2,
                    FBA_B(3) => b2a3,
                    FBA_S(0) => product(2),
                    FBA_S(1) => sum_1(0),
                    FBA_S(2) => sum_1(1),
                    FBA_S(3) => sum_1(2),
                    FBA_Cout => carry_1);
                    
        Four_Bit_Adder_2 : Four_Bit_Adder
            Port Map(
                    FBA_A(0) => sum_1(0),
                    FBA_A(1) => sum_1(1),
                    FBA_A(2) => sum_1(2),
                    FBA_A(3) => carry_1,
                    FBA_B(0) => b3a0,
                    FBA_B(1) => b3a1,
                    FBA_B(2) => b3a2,
                    FBA_B(3) => b3a3,
                    FBA_S(0) => product(3),
                    FBA_S(1) => product(4),
                    FBA_S(2) => product(5),
                    FBA_S(3) => product(6),
                    FBA_Cout => product(7));
end FBM_Structural;
