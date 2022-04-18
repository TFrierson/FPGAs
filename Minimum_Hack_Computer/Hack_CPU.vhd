library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hack_CPU is
  Port (
        cpu_clk         : in std_logic;
        inM             : in std_logic_vector(15 downto 0);
        instruction_in  : in std_logic_vector(15 downto 0);
        reset           : in std_logic; 
        outM            : out std_logic_vector(15 downto 0);
        writeM          : out std_logic;
        addressM        : out std_logic_vector(2 downto 0);
        pc              : out std_logic_vector(14 downto 0));
end Hack_CPU;

architecture CPU_Structural of Hack_CPU is

signal not_instruction, load_A, load_D                  : std_logic;
signal to_AReg, AReg_Out, DReg_Out                      : std_logic_vector(15 downto 0);
signal amtoALU, out_ALU                                 : std_logic_vector(15 downto 0);
signal zr_sig, ng_sig                                   : std_logic;
signal pos, j3, j2, j1, jmp1, jmp_out, load_PC          : std_logic;
signal pc_out_sig                                       : std_logic_vector(15 downto 0);

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

component Program_Counter is
    Port (
        PC_Clk      : in std_logic;
        PC_In       : in std_logic_vector(15 downto 0);
        PC_Load     : in std_logic;
        Incr        : in std_logic;
        PC_Reset    : in std_logic; 
        PC_Out      : out std_logic_vector(15 downto 0));
end component Program_Counter;

component Hack_ALU16 is
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
end component Hack_ALU16;

begin

not_instruction <= NOT(instruction_in(15));
load_A <= not_instruction OR instruction_in(5);
load_D <= instruction_in(15) AND instruction_in(4);

To_AReg_Mux : Mux16
    Port Map(
            Mux16_A => instruction_in,
            Mux16_B => out_ALU,
            Mux16_Sel => instruction_in(15),
            Mux16_Out => to_AReg);

AReg : Register16
    Port Map(
            reg_clk => cpu_clk,
            reg_in => to_AReg,
            reg_load => load_A,
            reg_out => AReg_Out);

--Test Memory will have only 8 registers            
--addressM <= AReg_Out(14 downto 0);
addressM <= AReg_Out(2 downto 0);
            
DReg : Register16
    Port Map(
            reg_clk => cpu_clk,
            reg_in => out_ALU,
            reg_load => load_D,
            reg_out => DReg_Out);
            
AM_ALU_Mux : Mux16
    Port Map(
            Mux16_A => AReg_Out,
            Mux16_B => inM,
            Mux16_Sel => instruction_in(12),
            Mux16_Out => amtoALU);
            
ALU : Hack_ALU16
    Port Map(
            ALU_X => DReg_Out,
            ALU_Y => amtoALU,
            zx => instruction_in(11),
            nx => instruction_in(10),
            zy => instruction_in(9),
            ny => instruction_in(8),
            f => instruction_in(7),
            no => instruction_in(6),
            zr => zr_sig,
            ng => ng_sig,
            ALU_Out => out_ALU);
            
writeM <= instruction_in(15) AND instruction_in(3);
outM <= out_ALU;

--Circuit for jump logic for the Program Counter
pos <= NOT(zr_sig OR ng_sig);

j3 <= instruction_in(2) AND ng_sig;
j2 <= instruction_in(1) AND zr_sig;
j1 <= instruction_in(0) AND pos;

jmp1 <= j3 OR j2;
jmp_out <= jmp1 OR j1;
load_PC <= instruction_in(15) AND jmp_out;

CPU_PC : Program_Counter
    Port Map(
            PC_Clk => cpu_clk,
            PC_In => AReg_Out,
            PC_Load => load_pc,
            Incr => '1',
            PC_Reset => reset,
            PC_Out => pc_out_sig);
            
pc <= pc_out_sig(14 downto 0);

end CPU_Structural;
