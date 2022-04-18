library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM8 is
  Port (
        RAM8_Clk        : in std_logic;
        RAM8_In         : in std_logic_vector(15 downto 0);
        RAM8_Load       : in std_logic;
        RAM8_Address    : in std_logic_vector(2 downto 0);
        RAM8_Out        : out std_logic_vector(15 downto 0);
        test_out        : out std_logic_vector(15 downto 0));
end RAM8;

architecture RAM8_Struct of RAM8 is
component Register16 is
    Port (
        reg_clk     : in std_logic;
        reg_in      : in std_logic_vector(15 downto 0);
        reg_load    : in std_logic;
        reg_out     : out std_logic_vector(15 downto 0));
end component Register16;

component DMux8Way is
    Port (
        DM8_In  : in std_logic; 
        DM8_Sel : in std_logic_vector(2 downto 0);
        DM8_A   : out std_logic;
        DM8_B   : out std_logic;
        DM8_C   : out std_logic;
        DM8_D   : out std_logic;
        DM8_E   : out std_logic;
        DM8_F   : out std_logic;
        DM8_G   : out std_logic;
        DM8_H   : out std_logic);
end component DMux8Way;

component Mux8Way16 is
    Port (
        Mux8_A      : in std_logic_vector(15 downto 0);
        Mux8_B      : in std_logic_vector(15 downto 0);
        Mux8_C      : in std_logic_vector(15 downto 0);
        Mux8_D      : in std_logic_vector(15 downto 0);
        Mux8_E      : in std_logic_vector(15 downto 0);
        Mux8_F      : in std_logic_vector(15 downto 0);
        Mux8_G      : in std_logic_vector(15 downto 0);
        Mux8_H      : in std_logic_vector(15 downto 0);
        Mux8_Sel    : in std_logic_vector(2 downto 0);
        Mux8_Out    : out std_logic_vector(15 downto 0));
end component Mux8Way16;

signal load0, load1, load2, load3, load4, load5, load6, load7                           : std_logic;
signal reg0_out, reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out   : std_logic_vector(15 downto 0);
begin

Load_DMux : DMux8Way
    Port Map(
            DM8_In => RAM8_Load,
            DM8_Sel => RAM8_Address,
            DM8_A => load0,
            DM8_B => load1,
            DM8_C => load2,
            DM8_D => load3,
            DM8_E => load4,
            DM8_F => load5,
            DM8_G => load6,
            DM8_H => load7);

Register0 : Register16
    Port Map(
            reg_clk => RAM8_Clk,
            reg_in => RAM8_In,
            reg_load => load0,
            reg_out => reg0_out);
            
Register1 : Register16
    Port Map(
            reg_clk => RAM8_Clk,
            reg_in => RAM8_In,
            reg_load => load1,
            reg_out => reg1_out);
            
Register2 : Register16
    Port Map(
            reg_clk => RAM8_Clk,
            reg_in => RAM8_In,
            reg_load => load2,
            reg_out => reg2_out);
           
Register3 : Register16
    Port Map(
            reg_clk => RAM8_Clk,
            reg_in => RAM8_In,
            reg_load => load3,
            reg_out => reg3_out);
            
Register4 : Register16
    Port Map(
            reg_clk => RAM8_Clk,
            reg_in => RAM8_In,
            reg_load => load4,
            reg_out => reg4_out);
            
Register5 : Register16
    Port Map(
            reg_clk => RAM8_Clk,
            reg_in => RAM8_In,
            reg_load => load5,
            reg_out => reg5_out);
            
Register6 : Register16
    Port Map(
            reg_clk => RAM8_Clk,
            reg_in => RAM8_In,
            reg_load => load6,
            reg_out => reg6_out);
            
Register7 : Register16
    Port Map(
            reg_clk => RAM8_Clk,
            reg_in => RAM8_In,
            reg_load => load7,
            reg_out => reg7_out);
            
Out_Mux : Mux8Way16
    Port Map(
            Mux8_A => reg0_out,
            Mux8_B => reg1_out,
            Mux8_C => reg2_out,
            Mux8_D => reg3_out,
            Mux8_E => reg4_out,
            Mux8_F => reg5_out,
            Mux8_G => reg6_out,
            Mux8_H => reg7_out,
            Mux8_Sel => RAM8_Address,
            Mux8_Out => RAM8_Out);
            
test_out <= reg0_out;
end RAM8_Struct;
