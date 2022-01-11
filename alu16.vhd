--This is going to be my very first 16-bit ALU. The operations
--will be:
--1. Add 
--2. Subtract 
--3. And 
--4. Or 
--5. Not 
--6. Xor 
--The inputs for the data and operation in will be via the switches on the
--board. The buttons on the board will be for reset, push reg A, reg B, and
--reg op 


--Register16 Entity
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register16 is
    Port(Data   : in STD_LOGIC_VECTOR(15 downto 0);
         Load   : in STD_LOGIC;
         Clk    : in STD_LOGIC;
         Reset  : in STD_LOGIC;
         Q      : out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture Reg_Behavioral of Register16 is
begin
process(Clk,Reset)
begin
    if Reset = '1' then
        Q <= (others => '0');
    else
        if rising_edge(Clk) then
            if load = '1' then
                Q <= Data;
            end if;
        end if;
    end if;
end process;
end Reg_Behavioral;


--Half Adder entity
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Half_Adder is
    Port(HA_A   : in STD_LOGIC;
         HA_B   : in STD_LOGIC;
         HA_S   : out STD_LOGIC;
         HA_C   : out STD_LOGIC);
end Half_Adder;

architecture HA_Behavioral of Half_Adder is
begin
HA_S <= HA_A XOR HA_B;
HA_C <= HA_A AND HA_B;
end HA_Behavioral;

--Full Adder entity
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Full_Adder is
    Port(FA_A       : in STD_LOGIC;
         FA_B       : in STD_LOGIC;
         FA_Cin     : in STD_LOGIC;
         FA_S       : out STD_LOGIC;
         FA_Cout    : out STD_LOGIC);
end Full_Adder;

architecture FA_Dataflow of Full_Adder is
begin
    FA_S <= FA_A XOR FA_B XOR FA_Cin;
    FA_Cout <= (FA_A AND FA_B) OR (FA_B AND FA_Cin) OR (FA_A AND FA_Cin);
end FA_Dataflow;

--16 Bit Adder entity
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Adder_16_Bit is
    Port(Add_A  : in STD_LOGIC_VECTOR(15 downto 0);
         Add_B  : in STD_LOGIC_VECTOR(15 downto 0);
         Sum    : out STD_LOGIC_VECTOR(15 downto 0));
end Adder_16_Bit;

architecture Add_Structural of Adder_16_Bit is
component Half_Adder is 
    Port(HA_A, HA_B : in STD_LOGIC;
         HA_S, HA_C  : out STD_LOGIC);
end component;

component Full_Adder is
    Port(FA_A, FA_B, FA_Cin : in STD_LOGIC;
         FA_S, FA_Cout  : out STD_LOGIC);
end component;

signal carry : STD_LOGIC_VECTOR(14 downto 0);
begin
    Half_Adder0  : Half_Adder Port Map(Add_A(0),Add_B(0),Sum(0),carry(0));
    Full_Adder1  : Full_Adder Port Map(Add_A(1),Add_B(1),carry(0),Sum(1),carry(1));
    Full_Adder2  : Full_Adder Port Map(Add_A(2),Add_B(2),carry(1),Sum(2),carry(2));
    Full_Adder3  : Full_Adder Port Map(Add_A(3),Add_B(3),carry(2),Sum(3),carry(3));
    Full_Adder4  : Full_Adder Port Map(Add_A(4),Add_B(4),carry(3),Sum(4),carry(4));
    Full_Adder5  : Full_Adder Port Map(Add_A(5),Add_B(5),carry(4),Sum(5),carry(5));
    Full_Adder6  : Full_Adder Port Map(Add_A(6),Add_B(6),carry(5),Sum(6),carry(6));
    Full_Adder7  : Full_Adder Port Map(Add_A(7),Add_B(7),carry(6),Sum(7),carry(7));
    Full_Adder8  : Full_Adder Port Map(Add_A(8),Add_B(8),carry(7),Sum(8),carry(8));
    Full_Adder9  : Full_Adder Port Map(Add_A(9),Add_B(9),carry(8),Sum(9),carry(9));
    Full_Adder10  : Full_Adder Port Map(Add_A(10),Add_B(10),carry(9),Sum(10),carry(10));
    Full_Adder11  : Full_Adder Port Map(Add_A(11),Add_B(11),carry(10),Sum(11),carry(11));
    Full_Adder12  : Full_Adder Port Map(Add_A(12),Add_B(12),carry(11),Sum(12),carry(12));
    Full_Adder13  : Full_Adder Port Map(Add_A(13),Add_B(13),carry(12),Sum(13),carry(13));
    Full_Adder14  : Full_Adder Port Map(Add_A(14),Add_B(14),carry(13),Sum(14),carry(14));
    Full_Adder15  : Full_Adder Port Map(Add_A(15),Add_B(15),carry(14),Sum(15),open);
end Add_Structural;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
entity alu16 is
    Port ( Clk_Main                 : in STD_LOGIC;
           Input                    : in STD_LOGIC_VECTOR(15 downto 0);
           Push_RegA                : in STD_LOGIC;
           Push_RegB                : in STD_LOGIC;
           Push_RegOp               : in STD_lOGIC;
           Reset_Main               : in STD_LOGIC;
           ALU_Out                  : out STD_LOGIC_VECTOR(15 downto 0));
end alu16;

architecture Behavioral of alu16 is

component Register16 is 
    Port(Data   : in STD_LOGIC_VECTOR(15 downto 0);
         Load   : in STD_LOGIC;
         Clk    : in STD_LOGIC;
         Reset  : in STD_LOGIC;
         Q      : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Adder_16_Bit is 
    Port(Add_A  : in STD_LOGIC_VECTOR(15 downto 0);
         Add_B  : in STD_LOGIC_VECTOR(15 downto 0);
         Sum    : out STD_LOGIC_VECTOR(15 downto 0));
end component;

signal A_Out, B_Out, Adder_Out0, Op_Out             : STD_LOGIC_VECTOR(15 downto 0);
signal Temp0, Temp1, Adder_Out1, Adder_Out2         : STD_LOGIC_VECTOR(15 downto 0);
signal NotB                                         : STD_LOGIC_VECTOR(15 downto 0);

begin
--Instantiate the Registers and Adder
A_Register  : Register16 Port Map(Input, Push_RegA, Clk_Main, Reset_Main,A_Out);
B_Register  : Register16 Port Map(Input, Push_RegB, Clk_Main, Reset_Main,B_Out);
Op_Register : Register16 Port Map(Input, Push_RegOp, Clk_Main, Reset_Main, Op_Out);
Adder0       : Adder_16_Bit Port Map(A_Out, B_Out, Adder_Out0);
Adder1       : Adder_16_Bit Port Map(A_Out, NotB, Temp0);
Adder2       : Adder_16_Bit Port Map(Temp0, "0000000000000001", Temp1);
NotB <= not B_Out;
    
process(Clk_Main, Reset_Main, Push_RegOp, Op_Out)
begin
    if Reset_Main = '1' then
        ALU_Out <= "0000000000000000";
        
    else
    if rising_edge(Clk_Main) then
        if Push_RegOp = '1' then
        
            case Op_Out is
                when "0000000000000000" => ALU_Out <= Adder_Out0;              --Add
                when "0000000000000001"  => ALU_Out <= Temp1;                  --Subtract
                when "0000000000000010" => ALU_Out <=  A_Out and B_Out;        --And
                when "0000000000000011" => ALU_Out <= A_Out or B_Out;          --Or
                when "0000000000000100" => ALU_Out <= A_Out xor B_Out;         --Xor
                when "0000000000000101" => ALU_Out <= not A_Out;               --Not
                when others => ALU_Out <= "1111111111111111";                  --Error
            end case;
        end if;
     end if;
    end if;
end process;

end Behavioral;
