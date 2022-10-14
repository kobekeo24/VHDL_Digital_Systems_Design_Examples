----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2022 08:38:39 AM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
--  Port ( );
generic(delay : integer := 6500000/10);
port(btn   : in std_logic;
     clk    : in std_logic;
     btn_ctr: out std_logic);
end debounce;

architecture Behavioral of debounce is
signal count         :   integer := 0;
signal current_state : std_logic := '1'; 
begin
process(clk)
begin
if rising_edge(clk) then
    if(current_state /= btn) then
        current_state <= btn;
        count <= 0;
    elsif(count = delay) then
        btn_ctr <= current_state;
    else
        count <= count + 1;
    end if;    
end if;

end process;

end Behavioral;
