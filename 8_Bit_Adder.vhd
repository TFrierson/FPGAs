library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Half-Adder component 
entity Half_Adder is
    Port(HA_A   : in STD_LOGIC;
         HA_B   : in STD_LOGIC;
         HA_S   : out STD_LOGIC;
         HA_Cout    : out STD_LOGIC);
end entity Half_Adder;

architecture ha_dataflow of Half_Adder is
begin
    HA_S <= HA_A XOR HA_B;
    HA_Cout <= HA_A AND HA_B;
end ha_dataflow;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Full-Adder component
entity Full_Adder is
    Port(FA_A  : in STD_LOGIC;
         FA_B  : in STD_LOGIC;
         FA_Cin : in STD_LOGIC;
         FA_S   : out STD_LOGIC;
         FA_Cout    : out STD_LOGIC);
end entity Full_Adder;

architecture fa_dataflow of Full_Adder is
begin
    FA_S <= FA_A XOR FA_B XOR FA_Cin;
    FA_Cout <= (FA_A AND FA_B) OR (FA_B AND FA_Cin) OR (FA_A AND FA_Cin);
end architecture fa_dataflow;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Eight_Bit_Adder is
    Port ( A : in STD_LOGIC_VECTOR(7 downto 0);
           B : in STD_LOGIC_VECTOR(7 downto 0);
           Sum  : out STD_LOGIC_VECTOR(7 downto 0));
end Eight_Bit_Adder;

architecture structural of Eight_Bit_Adder is


component Half_Adder is 
    Port(HA_A, HA_B : in STD_LOGIC;
         HA_S, HA_Cout  : out STD_LOGIC);
end component;

component Full_Adder is
    Port(FA_A, FA_B, FA_Cin : in STD_LOGIC;
         FA_S, FA_Cout  : out STD_LOGIC);
end component;

--Internal signals 
signal carry : STD_LOGIC_VECTOR(6 downto 0);
begin
    Half_Adder0  : Half_Adder Port Map(A(0),B(0),Sum(0),carry(0));
    Full_Adder1  : Full_Adder Port Map(A(1),B(1),carry(0),Sum(1),carry(1));
    Full_Adder2  : Full_Adder Port Map(A(2),B(2),carry(1),Sum(2),carry(2));
    Full_Adder3  : Full_Adder Port Map(A(3),B(3),carry(2),Sum(3),carry(3));
    Full_Adder4  : Full_Adder Port Map(A(4),B(4),carry(3),Sum(4),carry(4));
    Full_Adder5  : Full_Adder Port Map(A(5),B(5),carry(4),Sum(5),carry(5));
    Full_Adder6  : Full_Adder Port Map(A(6),B(6),carry(5),Sum(6),carry(6));
    Full_Adder7  : Full_Adder Port Map(A(7),B(7),carry(6),Sum(7),open);

end structural;