--It turns out, that the cathodes for
--each of the digits on the 7-segment display on the Basys3 
--board are all connected. So, to display different numbers 
--on the different digits, we need to individually activate 
--each digit (anode) every millisecond to make the activations 
--invisible to the human eye.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--First, I will figure out how to get the LEDs in the
--7 Segment Display Lit. Then I will try clock input (binary to decimal)
entity sdp0 is
    Port(clk_in         : in std_logic;
         reset          : in std_logic;
         anode_activate : out std_logic_vector(3 downto 0);
         led_out        : out std_logic_vector(7 downto 0));
         
end sdp0;

architecture Behavioral of sdp0 is

signal second_timer         : std_logic_vector(26 downto 0) := (others => '0');
signal mil_second_counter   : std_logic_vector(18 downto 0) := (others => '0');
signal activate_counter     : std_logic_vector(1 downto 0);
signal number_to_display    : std_logic_vector(15 downto 0) := (others => '0');
signal led_bcd              : std_logic_vector(3 downto 0) := (others => '0');

begin

process(clk_in,reset)
    begin
    if reset = '1' then
        second_timer <= (others => '0');
        mil_second_counter <= (others => '0');
        number_to_display <= (others => '0');
    else
        if rising_edge(clk_in) then
            if second_timer = 50000000 then
                second_timer <= (others => '0');
                
                if number_to_display = "1111111111111111" then
                    number_to_display <= (others => '0');
                else
                    number_to_display <= number_to_display + 1;
                end if;
            end if;
            
            if mil_second_counter = "1111111111111111111" then
                mil_second_counter <= (others => '0');
            end if;
            
            second_timer <= second_timer + 1;
            mil_second_counter <= mil_second_counter + 1;
         end if;
     end if;
end process;

activate_counter <= mil_second_counter(18 downto 17);

process(activate_counter)
begin
case activate_counter is 
    when "00" => 
        anode_activate <= "0111";
        led_bcd <= number_to_display(15 downto 12);
    when "01" => 
        anode_activate <= "1011";
        led_bcd <= number_to_display(11 downto 8);
    when "10" => 
        anode_activate <= "1101";
        led_bcd <= number_to_display(7 downto 4);
    when "11" => 
        anode_activate <= "1110";
        led_bcd <= number_to_display(3 downto 0);
end case;
end process;

--All LEDs are on if anode_activate = "0000" and       
--led_out = "00000000"
process(led_bcd)
begin
case led_bcd is
    when "0000" => led_out <= "00000011"; --0 
    when "0001" => led_out <= "10011111"; --1 
    when "0010" => led_out <= "00100101"; --2 
    when "0011" => led_out <= "00001101"; --3 
    when "0100" => led_out <= "10011001"; --4 
    when "0101" => led_out <= "01001001"; --5 
    when "0110" => led_out <= "01000001"; --6 
    when "0111" => led_out <= "00011111"; --7 
    when "1000" => led_out <= "00000001"; --8 
    when "1001" => led_out <= "00011001"; --9
    when "1010" => led_out <= "00000101"; --a 
    when "1011" => led_out <= "11000001"; --b 
    when "1100" => led_out <= "11100101"; --c 
    when "1101" => led_out <= "10000101"; --d 
    when "1110" => led_out <= "01100001"; --E  
    when "1111" => led_out <= "01110001"; --F
    when others => led_out <= "11111111"; --error
end case;
end process;
end Behavioral;
