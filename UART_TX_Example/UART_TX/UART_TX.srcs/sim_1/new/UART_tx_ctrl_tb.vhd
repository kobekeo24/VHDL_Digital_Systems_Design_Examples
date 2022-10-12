----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2022 03:04:54 PM
-- Design Name: 
-- Module Name: UART_tx_ctrl_tb - Behavioral
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

entity UART_tx_ctrl_tb is
--  Port ( );
end UART_tx_ctrl_tb;

architecture Behavioral of UART_tx_ctrl_tb is

signal send_t   : std_logic := '0';
signal clk_t    : std_logic := '0';
signal data_t   : std_logic_vector (7 downto 0) := x"41";
signal ready_t  : std_logic := '0';
signal uart_tx_t: std_logic := '1';

component UART_TX_CTRL
generic(baud : integer := 9600);
port(send   : in std_logic;
     clk    : in std_logic;
     data   : in std_logic_vector (7 downto 0);
     ready  : out std_logic;
     uart_tx: out std_logic);
end component;

begin
clk_t <= not clk_t after 5 ns;

UUT: UART_TX_CTRL port map (send => send_t,
                            clk => clk_t,
                            data => data_t,
                            ready => ready_t,
                            uart_tx => uart_tx_t);

Stimulus_process: process is
begin
    wait for 200ns;
    send_t <= '1'; wait for 1000us;
    data_t <= x"AE"; wait for 1us;
end process;




end Behavioral;
