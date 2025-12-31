----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.09.2025 14:23:29
-- Design Name: 
-- Module Name: Adder2_tbench - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bit4_counter_tbench is
--  Port ( );
end bit4_counter_tbench;

architecture Behavioral of bit4_counter_tbench is
    component bit4_counter is
        port (
        selector, reset, clk  : in std_logic;
        Y  : out std_logic_vector(3 downto 0)
        );
    end component; 

signal selector, reset, clk: std_logic := '0';
signal Y: std_logic_vector(3 downto 0);

begin
uut : bit4_counter port map(
    reset => reset,
    clk => clk,
    selector => selector,
    Y => Y
    );

clk_proc: process
begin
    wait for 4 ns;
    clk <= not clk;
end process clk_proc;

stim_proc : process
begin
     reset <= '1';
     wait for 24 ns;
     reset <= '0';
     selector <= '1'; 
     wait for 200 ns;    

     selector <= '0';  
     wait for 300 ns;    

     reset <= '1';     
     wait for 24 ns;
     reset <= '0';

     wait;
    end process stim_proc;

end Behavioral;
