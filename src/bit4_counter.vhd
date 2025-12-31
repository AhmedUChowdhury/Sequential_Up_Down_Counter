----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2025 19:40:04
-- Design Name: 
-- Module Name: bit4_counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bit4_counter is
    Port ( selector : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end bit4_counter;

architecture Behavioral of bit4_counter is

signal Y_signed : signed(3 downto 0) := (others => '0');
signal slow_clk : std_logic := '0';
signal counter  : integer range 0 to 124999999 := 0;

begin

    slow_clk_gen: process(clk)
    begin
        if rising_edge(clk) then
            if counter = 124999999 then
                slow_clk <= '1';
                counter <= 0;
            else
                slow_clk <= '0';
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    accumulator: process(slow_clk, reset)
    begin
        if reset = '1' then 
            Y_signed <= (others => '0');
        elsif rising_edge(slow_clk) then
            if selector = '1' and Y_signed < "0111" then
                Y_signed <= Y_signed + 1;
            elsif selector = '0' and Y_signed > "1000" then
                Y_signed <= Y_signed - 1;
            else
                Y_signed <= Y_signed;
            end if;
        end if;
    end process;
    
    Y <= std_logic_vector(Y_signed);

end Behavioral;
