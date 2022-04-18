library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity And16 is
  Port (
        And_A   : in std_logic_vector(15 downto 0);
        And_B   : in std_logic_vector(15 downto 0);
        And_Out : out std_logic_vector(15 downto 0));
end And16;

architecture And_Dataflow of And16 is

begin
And_Out(0) <= And_A(0) AND And_B(0);
And_Out(1) <= And_A(1) AND And_B(1);
And_Out(2) <= And_A(2) AND And_B(2);
And_Out(3) <= And_A(3) AND And_B(3);
And_Out(4) <= And_A(4) AND And_B(4);
And_Out(5) <= And_A(5) AND And_B(5);
And_Out(6) <= And_A(6) AND And_B(6);
And_Out(7) <= And_A(7) AND And_B(7);
And_Out(8) <= And_A(8) AND And_B(8);
And_Out(9) <= And_A(9) AND And_B(9);
And_Out(10) <= And_A(10) AND And_B(10);
And_Out(11) <= And_A(11) AND And_B(11);
And_Out(12) <= And_A(12) AND And_B(12);
And_Out(13) <= And_A(13) AND And_B(13);
And_Out(14) <= And_A(14) AND And_B(14);
And_Out(15) <= And_A(15) AND And_B(15);

end And_Dataflow;
