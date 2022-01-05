library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keypad0 is
    Port(clk              : in std_logic;
         Rows             : in std_logic_vector(3 downto 0);
         Columns          : out std_logic_vector(3 downto 0);
         Anode_Out        : out std_logic_vector(3 downto 0);
         LED_Signal       : out std_logic_vector(7 downto 0));
         
end keypad0;

architecture Behavioral of keypad0 is

signal millisec_timer   : std_logic_vector(19 downto 0) := (others => '0');
signal circuit_timer    : std_logic_vector(1 downto 0);

begin

Anode_Out <= "1110";

process(clk)
begin
    if rising_edge(clk) then
        if millisec_timer = "1111111111111111111" then
            millisec_timer <= (others => '0');
        end if;
        
        millisec_timer <= millisec_timer + 1;
    end if;

end process;

circuit_timer <= millisec_timer(19 downto 18);

process(circuit_timer)
begin

case circuit_timer is
    when "00" => 
        Columns <= "0111";
        case Rows is 
            when "0111" =>      --A is pressed
                LED_Signal <= "00010001";
            when "1011" =>      --B is pressed 
                LED_Signal <= "11000001";
            when "1101" =>      --C is pressed
                LED_Signal <= "01100011";
            when "1110" =>      --D is pressed 
                LED_Signal <= "10000101";
            when others => 
                LED_Signal <= "11111111";                
        end case;
        
     when "01" => 
        Columns <= "1011";
        case Rows is 
            when "0111" =>      --3 is pressed
                LED_Signal <= "00001101";
            when "1011" =>      --6 is pressed 
                LED_Signal <= "01000001";
            when "1101" =>      --9 is pressed
                LED_Signal <= "00011001";
            when "1110" =>      --E is pressed 
                LED_Signal <= "01100001";
            when others => 
                LED_Signal <= "11111111";
         end case;
         
      when "10" => 
        Columns <= "1101";
        case Rows is 
            when "0111" =>      --2 is pressed
                LED_Signal <= "00100101";
            when "1011" =>      --5 is pressed 
                LED_Signal <= "01001001";
            when "1101" =>      --8 is pressed
                LED_Signal <= "00000001";
            when "1110" =>      --F is pressed 
                LED_Signal <= "01110001";
            when others => 
                LED_Signal <= "11111111";
         end case;
         
      when "11" => 
        Columns <= "1110";
        case Rows is 
            when "0111" =>      --1 is pressed
                LED_Signal <= "10011111";
            when "1011" =>      --4 is pressed 
                LED_Signal <= "10011001";
            when "1101" =>      --7 is pressed
                LED_Signal <= "00011111";
            when "1110" =>      --0 is pressed 
                LED_Signal <= "00000011";
            when others => 
                LED_Signal <= "11111111";
         end case;
end case;
end process;
end Behavioral;
