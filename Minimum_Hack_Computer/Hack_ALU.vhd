-- Implementation: the ALU logic manipulates the x and y inputs
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hack_ALU16 is
  Port (
        ALU_X   : in std_logic_vector(15 downto 0);
        ALU_Y   : in std_logic_vector(15 downto 0);
        zx      : in std_logic;
        nx      : in std_logic;
        zy      : in std_logic;
        ny      : in std_logic;
        f       : in std_logic;
        no      : in std_logic;
        zr      : out std_logic;
        ng      : out std_logic;
        ALU_Out : out std_logic_vector(15 downto 0));
end Hack_ALU16;

architecture ALU16_Structural of Hack_ALU16 is

component Mux16 is
    Port (
        Mux16_A     : in std_logic_vector(15 downto 0);
        Mux16_B     : in std_logic_vector(15 downto 0);
        Mux16_Sel   : in std_logic;
        Mux16_Out   : out std_logic_vector(15 downto 0));
end component Mux16;

component Not_16 is
    Port (
        Not16_In    : in std_logic_vector(15 downto 0);
        Not16_Out   : out std_logic_vector(15 downto 0) );
end component Not_16;

component And16 is 
    Port (
        And_A   : in std_logic_vector(15 downto 0);
        And_B   : in std_logic_vector(15 downto 0);
        And_Out : out std_logic_vector(15 downto 0));
end component And16;

component Or8Way is
    Port (
        Or8_In  : in std_logic_vector(7 downto 0);
        Or8_Out : out std_logic);
end component Or8Way;

component Adder16 is
    Port (
        Adder16_A   : in std_logic_vector(15 downto 0);
        Adder16_B   : in std_logic_vector(15 downto 0);
        Adder16_Out : out std_logic_vector(15 downto 0));
end component Adder16;

signal zx_out, zy_out, notx_out, noty_out, nx_out, ny_out, addxy_out, andxy_out, fout, nfout    : std_logic_vector(15 downto 0);
signal comp_out     : std_logic_vector(15 downto 0); 
signal zr_0, zr_1   : std_logic_vector(7 downto 0);
signal or8_0, or8_1, or_final    : std_logic;

begin

ZX_Mux : Mux16
    Port Map(
            Mux16_A => ALU_X,
            Mux16_B => "0000000000000000",
            Mux16_Sel => zx,
            Mux16_Out => zx_out);

ZY_Mux : Mux16
    Port Map(
            Mux16_A => ALU_Y,
            Mux16_B => "0000000000000000",
            Mux16_Sel => zy,
            Mux16_Out => zy_out);
            
NotX : Not_16
    Port Map(
            Not16_In => zx_out,
            Not16_Out => notx_out);

NotY : Not_16
    Port Map(
            Not16_In => zy_out,
            Not16_out => noty_out);
            
NX_Mux : Mux16
    Port Map(
            Mux16_A => zx_out,
            Mux16_B => notx_out,
            Mux16_Sel => nx,
            Mux16_Out => nx_out);
            
NY_Mux : Mux16
    Port Map(
            Mux16_A => zy_out,
            Mux16_B => noty_out,
            Mux16_Sel => ny,
            Mux16_Out => ny_out);
            
ALU_Add : Adder16
    Port Map(
            Adder16_A => nx_out,
            Adder16_B => ny_out,
            Adder16_Out => addxy_out);

ALU_And : And16
    Port Map(
            And_A => nx_out,
            And_B => ny_out,
            And_Out => andxy_out);
            
FOut_Mux : Mux16
    Port Map(
            Mux16_A => andxy_out,
            Mux16_B => addxy_out,
            Mux16_Sel => f,
            Mux16_Out => fout);
            
NotF : Not_16
    Port Map(
            Not16_In => fout,
            Not16_Out => nfout);
            
Final_Out : Mux16
    Port Map(
            Mux16_A => fout,
            Mux16_B => nfout,
            Mux16_Sel => no,
            Mux16_Out => comp_out);
           
ALU_Out <= comp_out;
ng <= comp_out(15);

zr_0(0) <= comp_out(0);
zr_0(1) <= comp_out(1);
zr_0(2) <= comp_out(2);
zr_0(3) <= comp_out(3);
zr_0(4) <= comp_out(4);
zr_0(5) <= comp_out(5);
zr_0(6) <= comp_out(6);
zr_0(7) <= comp_out(7);

zr_1(0) <= comp_out(8);
zr_1(1) <= comp_out(9);
zr_1(2) <= comp_out(10);
zr_1(3) <= comp_out(11);
zr_1(4) <= comp_out(12);
zr_1(5) <= comp_out(13);
zr_1(6) <= comp_out(14);
zr_1(7) <= comp_out(15);

Or8_A : Or8Way
    Port Map(
            Or8_In => zr_0,
            Or8_Out => or8_0);
            
 Or8_B : Or8Way
    Port Map(
            Or8_In => zr_1,
            Or8_Out => or8_1);
            
zr <= NOT(or8_0 OR or8_1);

end ALU16_Structural;
