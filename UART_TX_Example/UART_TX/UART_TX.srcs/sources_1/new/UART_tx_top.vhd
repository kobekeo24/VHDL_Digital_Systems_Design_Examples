----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2022 09:56:27 AM
-- Design Name: 
-- Module Name: UART_tx_top - Behavioral
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
use ieee.numeric_std;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_tx_top is
--  Port ( );
port(btnC : in std_logic;
     clk  : in std_logic;
     RsTx: out std_logic);
end UART_tx_top;

architecture Behavioral of UART_tx_top is

type state_type is (TX_WAIT_BTN,TX_SEND_CHAR,TX_SEND_WAIT);

signal state : state_type := TX_WAIT_BTN;
signal index : integer;
signal count : integer := 5;
signal uartRdy: std_logic;
signal uartRdyPrev  : std_logic;
signal uartSend     : std_logic;
signal uartSendPrev : std_logic;
signal uartData:std_logic_vector(7 downto 0);
signal initStr: std_logic_vector(7 downto 0);
signal btnCclr: std_logic;
signal btnC_prev: std_logic;
signal helloStr: std_logic_vector(39 downto 0) := x"4F4C4C4548";

component UART_tx_ctrl is
generic(baud : integer);
port(send   : in std_logic;
     clk    : in std_logic;
     data   : in std_logic_vector (7 downto 0);
     ready  : out std_logic;
     uart_tx: out std_logic);
end component UART_tx_ctrl;

component debounce is
generic(delay : integer);
port(btn   : in std_logic;
     clk    : in std_logic;
     btn_ctr: out std_logic);
end component debounce;

begin
index <= count;
process(clk)
begin
if rising_edge(clk) then
uartRdyPrev <= uartRdy;
uartSendPrev <= uartSend;
btnC_prev <= btnCclr;
case state is
when TX_WAIT_BTN =>
    if btnC_prev = '0' and btnCclr = '1' then
        state <= TX_SEND_CHAR;
    end if;
when TX_SEND_CHAR =>
    uartData <= helloStr(index*8-1 downto (index-1)*8);
    state <= TX_SEND_WAIT;
    
when TX_SEND_WAIT =>
    if uartRdy = '1' then
        if index = 0  then 
            index <= 5;
        else
            index <= index - 1;
        end if;
        state <= TX_WAIT_BTN;
    end if;
end case;
end if;
end process;

uartSend <= '1' when (state = TX_SEND_CHAR) else '0';
TX : UART_tx_ctrl generic map(baud => 19200)
port map(send => uartSend, data => uartData, clk => clk, ready => uartRdy, uart_tx => RsTx);

dbc: debounce generic map(delay => 50000000/10)
port map(btn => btnC,clk => clk ,btn_ctr => btnCclr);
end Behavioral;
