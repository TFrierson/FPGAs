library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hack_ROM is
  Port (
        ROM_Clk     : in std_logic; 
        ROM_Address : in std_logic_vector(2 downto 0);
        ROM_Out     : out std_logic_vector(15 downto 0));
end Hack_ROM;

architecture ROM_Structural of Hack_ROM is
component Register16 is
    Port (
        reg_clk     : in std_logic;
        reg_in      : in std_logic_vector(15 downto 0);
        reg_load    : in std_logic;
        reg_out     : out std_logic_vector(15 downto 0));
end component Register16;

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

signal reg0_out : std_logic_vector(15 downto 0);
signal reg1_out : std_logic_vector(15 downto 0);
signal reg2_out : std_logic_vector(15 downto 0);
signal reg3_out : std_logic_vector(15 downto 0);
signal reg4_out : std_logic_vector(15 downto 0);
signal reg5_out : std_logic_vector(15 downto 0);

begin
ROM_0 : Register16
    Port Map(
            reg_clk => ROM_Clk,
            reg_in => "0000000000000010",
            reg_load => '1',
            reg_out => reg0_out);
            
ROM_1 : Register16
    Port Map(
            reg_clk => ROM_Clk,
            reg_in => "1110110000010000",
            reg_load => '1',
            reg_out => reg1_out);
            
ROM_2 : Register16
    Port Map(
            reg_clk => ROM_Clk,
            reg_in => "0000000000000011",
            reg_load => '1',
            reg_out => reg2_out);
            
ROM_3 : Register16
    Port Map(
            reg_clk => ROM_Clk,
            reg_in => "1110000010010000",
            reg_load => '1',
            reg_out => reg3_out);
            
ROM_4 : Register16
    Port Map(
            reg_clk => ROM_Clk,
            reg_in => "0000000000000000",
            reg_load => '1',
            reg_out => reg4_out);
            
ROM_5 : Register16
    Port Map(
            reg_clk => ROM_Clk,
            reg_in => "1110001100001000",
            reg_load => '1',
            reg_out => reg5_out);
            
ROM_Out_Mux : Mux8Way16
    Port Map(
            Mux8_A => reg0_out,
            Mux8_B => reg1_out,
            Mux8_C => reg2_out,
            Mux8_D => reg3_out,
            Mux8_E => reg4_out,
            Mux8_F => reg5_out,
            Mux8_G => "0000000000000000",
            Mux8_H => "0000000000000000",
            Mux8_Sel => ROM_Address,
            Mux8_Out => ROM_Out);

end ROM_Structural;
