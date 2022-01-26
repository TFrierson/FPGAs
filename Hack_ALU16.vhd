--This is a 16 bit ALU as is specified in the book The Elements of Computing
--Systems by Noam Nisan and Shimon Schocken. I will build it like we do
--in the book, structurally. I will build it like my first ALU with 3 registers, so that 
--I can program and run this one on my Basys3 FPGA


-- * The ALU (Arithmetic Logic Unit).
 --* Computes one of the following functions:
 --* x+y, x-y, y-x, 0, 1, -1, x, y, -x, -y, !x, !y,
 --* x+1, y+1, x-1, y-1, x&y, x|y on two 16-bit inputs, 
 --* according to 6 input bits denoted zx,nx,zy,ny,f,no.
 --* In addition, the ALU computes two 1-bit outputs:
 --* if the ALU output == 0, zr is set to 1; otherwise zr is set to 0;
 --* if the ALU output < 0, ng is set to 1; otherwise ng is set to 0.

--Implementation: the ALU logic manipulates the x and y inputs
-- and operates on the resulting values, as follows:
-- if (zx == 1) set x = 0        // 16-bit constant
-- if (nx == 1) set x = !x       // bitwise not
-- if (zy == 1) set y = 0        // 16-bit constant
-- if (ny == 1) set y = !y       // bitwise not
-- if (f == 1)  set out = x + y  // integer 2's complement addition
-- if (f == 0)  set out = x & y  // bitwise and
-- if (no == 1) set out = !out   // bitwise not
-- if (out == 0) set zr = 1
-- if (out < 0) set ng = 1


--All tests are correct!

--Mux16 component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux16 is 
    Port(Mux_A          : in STD_LOGIC_VECTOR(15 downto 0);
         Mux_B          : in STD_LOGIC_VECTOR(15 downto 0);
         sel            : in STD_LOGIC; 
         Mux16_Out      : out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture Mux16_Dataflow of Mux16 is
begin
    with sel select
    Mux16_Out <= Mux_A when '0',
                 Mux_B when '1',
                 "0000000000000000" when others;
end Mux16_Dataflow;


--Not16 component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Not16 is
    Port(n_in   : in STD_LOGIC_VECTOR(15 downto 0);
         n_out  : out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture Not16_Behavioral of Not16 is
begin
    n_out <= not n_in;
end Not16_Behavioral;


--And16 component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity And16 is
    Port(And_A      : in STD_LOGIC_VECTOR(15 downto 0);
         And_B      : in STD_LOGIC_VECTOR(15 downto 0);
         And_Out    : out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture And_Behavioral of And16 is
begin
    And_Out <= And_A and And_B;
end And_Behavioral;


--Or_Gate component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Or_Gate is
    Port(Or_A   : in STD_LOGIC;
         Or_B   : in STD_LOGIC; 
         Or_Out : out STD_LOGIC);
end entity;

architecture Or_Behavioral of Or_Gate is
begin
    Or_Out <= Or_A or Or_B;
end Or_Behavioral;


--Or8Way component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Or8Way is
    Port(Or8_in      : in STD_LOGIC_VECTOR(7 downto 0);
         Or8_Out     : out STD_LOGIC);
end entity;

architecture Or8_Dataflow of Or8Way is
signal or_1, or_2, or_3, or_4, or_5, or_6   : STD_LOGIC;
begin
    or_1 <= Or8_in(7) or Or8_in(6);
    or_2 <= Or8_in(5) or Or8_in(4);
    or_3 <= Or8_in(3) or Or8_in(2);
    or_4 <= Or8_in(1) or Or8_in(0);
    or_5 <= or_1 or or_2;
    or_6 <= or_3 or or_4;
    Or8_Out <= or_5 or or_6;
end Or8_Dataflow;


--Half_Adder component for Add16 component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Half_Adder is 
    Port(HA_A       : in STD_LOGIC; 
         HA_B       : in STD_LOGIC; 
         HA_Sum     :    out STD_LOGIC;
         HA_Carry   : out STD_LOGIC);
end entity;

architecture HA_Dataflow of Half_Adder is
begin
    HA_Sum <= HA_A xor HA_B;
    HA_Carry <= HA_A and HA_B;
end HA_Dataflow;


--Full_Adder component for Add16
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is
    Port(FA_A       : in STD_LOGIC;
         FA_B       : in STD_LOGIC;
         FA_Cin     : in STD_LOGIC;
         FA_Sum     : out STD_LOGIC;
         FA_Cout    : out STD_LOGIC);
end entity;

architecture FA_Dataflow of Full_Adder is
begin
    FA_Sum <= FA_A XOR FA_B XOR FA_Cin;
    FA_Cout <= (FA_A AND FA_B) OR (FA_B AND FA_Cin) OR (FA_A AND FA_Cin);
end FA_Dataflow;


--Adder16 component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Add16 is
    Port(Add_A      : in STD_LOGIC_VECTOR(15 downto 0);
         Add_B      : in STD_LOGIC_VECTOR(15 downto 0);
         Add16_Sum  : out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture Add_Structural of Add16 is

component Half_Adder is 
    Port(HA_A : in STD_LOGIC;
         HA_B : in STD_LOGIC;
         HA_Sum : out STD_LOGIC; 
         HA_Carry  : out STD_LOGIC);
end component;

component Full_Adder is
    Port(FA_A   : in STD_LOGIC;
         FA_B   : in STD_LOGIC; 
         FA_Cin : in STD_LOGIC;
         FA_Sum : out STD_LOGIC; 
         FA_Cout  : out STD_LOGIC);
end component;

signal carry : STD_LOGIC_VECTOR(14 downto 0);
begin
    Half_Adder0  : Half_Adder Port Map(Add_A(0),Add_B(0),Add16_Sum(0),carry(0));
    Full_Adder1  : Full_Adder Port Map(Add_A(1),Add_B(1),carry(0),Add16_Sum(1),carry(1));
    Full_Adder2  : Full_Adder Port Map(Add_A(2),Add_B(2),carry(1),Add16_Sum(2),carry(2));
    Full_Adder3  : Full_Adder Port Map(Add_A(3),Add_B(3),carry(2),Add16_Sum(3),carry(3));
    Full_Adder4  : Full_Adder Port Map(Add_A(4),Add_B(4),carry(3),Add16_Sum(4),carry(4));
    Full_Adder5  : Full_Adder Port Map(Add_A(5),Add_B(5),carry(4),Add16_Sum(5),carry(5));
    Full_Adder6  : Full_Adder Port Map(Add_A(6),Add_B(6),carry(5),Add16_Sum(6),carry(6));
    Full_Adder7  : Full_Adder Port Map(Add_A(7),Add_B(7),carry(6),Add16_Sum(7),carry(7));
    Full_Adder8  : Full_Adder Port Map(Add_A(8),Add_B(8),carry(7),Add16_Sum(8),carry(8));
    Full_Adder9  : Full_Adder Port Map(Add_A(9),Add_B(9),carry(8),Add16_Sum(9),carry(9));
    Full_Adder10  : Full_Adder Port Map(Add_A(10),Add_B(10),carry(9),Add16_Sum(10),carry(10));
    Full_Adder11  : Full_Adder Port Map(Add_A(11),Add_B(11),carry(10),Add16_Sum(11),carry(11));
    Full_Adder12  : Full_Adder Port Map(Add_A(12),Add_B(12),carry(11),Add16_Sum(12),carry(12));
    Full_Adder13  : Full_Adder Port Map(Add_A(13),Add_B(13),carry(12),Add16_Sum(13),carry(13));
    Full_Adder14  : Full_Adder Port Map(Add_A(14),Add_B(14),carry(13),Add16_Sum(14),carry(14));
    Full_Adder15  : Full_Adder Port Map(Add_A(15),Add_B(15),carry(14),Add16_Sum(15),open);
end Add_Structural;


--16 bit Register component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register16 is
    Port(Clk        : in STD_LOGIC;
         Data       : in STD_LOGIC_VECTOR(15 downto 0);
         Load       : in STD_LOGIC;
         Reset      : in STD_LOGIC;
         Reg_Out    : out STD_LOGIC_VECTOR(15 downto 0));
end entity;

architecture Reg_Dataflow of Register16 is
begin
    process(Clk,Reset)
    begin
        if Reset = '1' then
            Reg_Out <= (others => '0');
        else
            if rising_edge(Clk) then
                if load = '1' then
                    Reg_Out <= Data;
                end if;
            end if;
        end if;
end process;
end Reg_Dataflow;


--Now, the main attraction: The Hack_Alu16!
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hack_ALU16 is
  Port (Clk_Main    : in STD_LOGIC;
        Input       : in STD_LOGIC_VECTOR(15 downto 0);
        Push_X      : in STD_LOGIC;
        Push_Y      : in STD_LOGIC;
        Push_Op     : in STD_LOGIC;
        Reset_Main  : in STD_LOGIC;
        ALU_Out     : out STD_LOGIC_VECTOR(15 downto 0);
        zr          : out STD_LOGIC;
        ng          : out STD_LOGIC);
end Hack_ALU16;

architecture Structural of Hack_ALU16 is

component Mux16 is
    Port(Mux_A          : in STD_LOGIC_VECTOR(15 downto 0);
         Mux_B          : in STD_LOGIC_VECTOR(15 downto 0);
         sel            : in STD_LOGIC; 
         Mux16_Out      : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Not16 is
    Port(n_in   : in STD_LOGIC_VECTOR(15 downto 0);
         n_out  : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component And16 is
    Port(And_A      : in STD_LOGIC_VECTOR(15 downto 0);
         And_B      : in STD_LOGIC_VECTOR(15 downto 0);
         And_Out    : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Or_Gate is
    Port(Or_A   : in STD_LOGIC;
         Or_B   : in STD_LOGIC; 
         Or_Out : out STD_LOGIC);
end component;

component Or8Way is
    Port(Or8_in      : in STD_LOGIC_VECTOR(7 downto 0);
         Or8_Out     : out STD_LOGIC);
end component;

component Add16 is
    Port(Add_A      : in STD_LOGIC_VECTOR(15 downto 0);
         Add_B      : in STD_LOGIC_VECTOR(15 downto 0);
         Add16_Sum  : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Register16 is
    Port(Clk        : in STD_LOGIC;
         Data       : in STD_LOGIC_VECTOR(15 downto 0);
         Load       : in STD_LOGIC;
         Reset      : in STD_LOGIC;
         Reg_Out    : out STD_LOGIC_VECTOR(15 downto 0));
end component;

--zx will be the most significant bit, no will be the least. "0000000000xxxxxx"
signal zx, nx, zy, ny, f, no    : STD_LOGIC;
signal X_Out, Y_Out, Op_Out     : STD_LOGIC_VECTOR(15 downto 0);
signal zx_out, nx_out, zy_out, ny_out, not_x, not_y, addxy, andxy, fout, nfout    : STD_LOGIC_VECTOR(15 downto 0);
signal out_sig : STD_LOGIC_VECTOR(15 downto 0);
signal zr0  : STD_LOGIC_VECTOR(7 downto 0);
signal zr1  : STD_LOGIC_VECTOR(7 downto 0);
signal or0, or1, or2 : STD_LOGIC;

begin
    X_Register  : Register16 Port Map(Clk_Main, Input, Push_X, Reset_Main, X_Out);
    Y_Register  : Register16 Port Map(Clk_Main, Input, Push_Y, Reset_Main, Y_Out); 
    Op_Register : Register16 Port Map(Clk_Main, Input, Push_Op, Reset_Main, Op_Out);
    
    --Assign the operations to the appropriate outputs from the Op_Register
    zx <= Op_Out(5);
    nx <= Op_Out(4);
    zy <= Op_Out(3);
    ny <= Op_Out(2);
    f <= Op_Out(1);
    no <= Op_Out(0);
                
    --If zx = 1, set x to 0, if zy = 1, set y to 0
    Mux16_zx : Mux16 Port Map(X_Out, "0000000000000000", zx, zx_out);
    Mux16_zy : Mux16 Port Map(Y_Out, "0000000000000000", zy, zy_out);
    
    --If nx = 1, set x = ~x. If ny = 1, set y = ~y
    X_Not16 : Not16 Port Map(zx_out, not_x);
    Y_Not16 : Not16 Port Map(zy_out, not_y);
    Nxout_Mux : Mux16 Port Map(zx_out, not_x, nx, nx_out);
    Nyout_Mux : Mux16 Port Map(zy_out, not_y, ny, ny_out);
    
    --If f = 1, then f = x + y. Else f = x& y
    Adder   : Add16 Port Map(nx_out, ny_out, addxy);
    f_And   : And16 Port Map(nx_out, ny_out, andxy);
    f_Mux   : Mux16 Port Map(andxy, addxy, f, fout);
    
    --The no bit
    No_Not  : Not16 Port Map(fout, nfout);
    
    Last_Mux    : Mux16 Port Map(fout, nfout, no, out_sig);
    ALU_Out <= out_sig;
    
    --The zr output
    zr0 <= out_sig(15 downto 8);
    zr1 <= out_sig(7 downto 0);
    
    Or8_0   : Or8Way Port Map(zr0, or0);
    Or8_1   : Or8Way Port Map(zr1, or1);
    Or_Final    : Or_Gate Port Map(or0, or1, or2);
    zr <= not or2;
    
    --The ng output
    ng <= out_sig(15);
    
end Structural;
