library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity half_adder is
    Port (A : in std_logic;
          B : in std_logic;
          S : out std_logic;
          C : out std_logic);
end half_adder;

architecture dataflow_ha of half_adder is
begin
    S <= A XOR B;
    C <= A AND B;
end dataflow_ha;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
entity or_gate is
    Port (A : in std_logic;
          B : in std_logic;
          orgate_out    : out std_logic);
end or_gate;

architecture dataflow_or of or_gate is
begin
    orgate_out <= A OR B;
end dataflow_or;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity full_adder is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           Cin : in STD_LOGIC;
           S_out : out STD_LOGIC;
           Tot_cout : out STD_LOGIC);
end full_adder;

architecture structural of full_adder is

component half_adder 
port(
    A   : in std_logic;
    B   : in std_logic;
    S   : out std_logic;
    C    : out std_logic);
end component;

component or_gate
port (
    A   : in std_logic;
    B   : in std_logic;
    orgate_out  : out std_logic);
end component;

--Internal signals 
signal half_sum, carry1, carry2 : std_logic := '0';

begin

--Instantiate the half-adders 
half_adder_1: half_adder port map(A => x, B => y, S => half_sum, C => carry1);
half_adder_2: half_adder port map(A => half_sum, B => Cin, S => S_out, C => carry2);
total_carry: or_gate port map (A => carry1, B => carry2, orgate_out => Tot_cout);

end structural;
