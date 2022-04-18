library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Program_Counter is
  Port (
        PC_Clk      : in std_logic;
        PC_In       : in std_logic_vector(15 downto 0);
        PC_Load     : in std_logic;
        Incr        : in std_logic;
        PC_Reset    : in std_logic; 
        PC_Out      : out std_logic_vector(15 downto 0));
end Program_Counter;

architecture PC_Structural of Program_Counter is

component Incrementer is
    Port (
        Incr_In     : in std_logic_vector(15 downto 0);
        Incr_Out    : out std_logic_vector(15 downto 0));
end component Incrementer;
        
component Mux16 is
    Port (
        Mux16_A     : in std_logic_vector(15 downto 0);
        Mux16_B     : in std_logic_vector(15 downto 0);
        Mux16_Sel   : in std_logic;
        Mux16_Out   : out std_logic_vector(15 downto 0));
end component Mux16;

component Register16 is
    Port (
        reg_clk     : in std_logic;
        reg_in      : in std_logic_vector(15 downto 0);
        reg_load    : in std_logic;
        reg_out     : out std_logic_vector(15 downto 0));
end component Register16;

signal register_out, inc_out, load_out, out_incr, reset_out : std_logic_vector(15 downto 0);
signal incr_logic : std_logic;

begin

Inc : Incrementer
    Port Map(
            Incr_In => register_out,
            Incr_Out => inc_out);
            
Inc_Mux : Mux16
    Port Map(
            Mux16_A => register_out,
            Mux16_B => inc_out,
            Mux16_Sel => Incr,
            Mux16_Out => out_incr);
            
Load_Mux : Mux16
    Port Map(
            Mux16_A => out_incr,
            Mux16_B => PC_In,
            Mux16_Sel => PC_Load,
            Mux16_Out => load_out);
            
Reset_Mux : Mux16
    Port Map(
            Mux16_A => load_out,
            Mux16_B => "0000000000000000",
            Mux16_Sel => PC_Reset,
            Mux16_Out => reset_out);
            
PC_Register : Register16
    Port Map(
            reg_clk => PC_Clk,
            reg_in => reset_out,
            reg_load => '1',
            reg_out => register_out);
            
PC_Out <= register_out;          

end PC_Structural;
