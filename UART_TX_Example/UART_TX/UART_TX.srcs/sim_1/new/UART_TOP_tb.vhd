----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/14/2022 07:16:07 PM
-- Design Name: 
-- Module Name: UART_TOP_tb - Behavioral
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

entity UART_TOP_tb is
--  Port ( );
end UART_TOP_tb;

architecture Behavioral of UART_TOP_tb is
signal btnC_t : std_logic := '0';
signal clk_t  : std_logic := '0';
signal TX     : std_logic := '1';  

component UART_tx_top is
--  Port ( );
port(btnC : in std_logic;
     clk  : in std_logic;
     RsTx: out std_logic);
end component UART_tx_top;

begin
clk_t <= not clk_t after 5 ns;

UUT: UART_tx_top port map (btnC => btnC_t,
                            clk => clk_t,
                            RsTx => TX);
                            
Stimulus_process: process is
begin
    btnC_t <= '0'; wait for 800ns;
    btnC_t <= '1'; wait for 1000ms;

end process;
end Behavioral;
