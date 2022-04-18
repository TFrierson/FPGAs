library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Min_Hack_Computer is
  Port (
        Main_Clk         : in std_logic;
        Main_Reset       : in std_logic;
        Comp_Out         : out std_logic_vector(15 downto 0));
end Min_Hack_Computer;

architecture MHC_Structural of Min_Hack_Computer is

component Hack_CPU is
    Port (
        cpu_clk         : in std_logic;
        inM             : in std_logic_vector(15 downto 0);
        instruction_in  : in std_logic_vector(15 downto 0);
        reset           : in std_logic; 
        outM            : out std_logic_vector(15 downto 0);
        writeM          : out std_logic;
        addressM        : out std_logic_vector(2 downto 0);
        pc              : out std_logic_vector(14 downto 0));
end component Hack_CPU;

component RAM8 is
    Port (
        RAM8_Clk        : in std_logic;
        RAM8_In         : in std_logic_vector(15 downto 0);
        RAM8_Load       : in std_logic;
        RAM8_Address    : in std_logic_vector(2 downto 0);
        RAM8_Out        : out std_logic_vector(15 downto 0);
        test_out        : out std_logic_vector(15 downto 0));
end component RAM8;

component Hack_ROM is
    Port (
        ROM_Clk     : in std_logic; 
        ROM_Address : in std_logic_vector(2 downto 0);
        ROM_Out     : out std_logic_vector(15 downto 0));
end component Hack_ROM;  

signal pc0      : std_logic_vector(14 downto 0);
signal pc_toROM, addr_Mem : std_logic_vector(2 downto 0);
signal instruction_out, mem_out, data_to_mem  : std_logic_vector(15 downto 0);
signal mem_load : std_logic;

begin

pc_toROM <= pc0(2 downto 0);

ROM : Hack_ROM
    Port Map(
            ROM_Clk => Main_Clk,
            ROM_Address => pc_toROM,
            ROM_Out => instruction_out);
            
CPU : Hack_CPU
    Port Map(
            cpu_clk => Main_Clk,
            inM => mem_out,
            instruction_in => instruction_out,
            reset => Main_Reset,
            outM => data_to_mem,
            writeM => mem_load,
            addressM => addr_Mem,
            pc => pc0);
            
Memory : RAM8
    Port Map(
            RAM8_Clk => Main_Clk,
            RAM8_In => data_to_mem,
            RAM8_Load => '1',
            RAM8_Address => addr_Mem,
            RAM8_Out => mem_out,
            test_out => Comp_Out);
            
end MHC_Structural;
