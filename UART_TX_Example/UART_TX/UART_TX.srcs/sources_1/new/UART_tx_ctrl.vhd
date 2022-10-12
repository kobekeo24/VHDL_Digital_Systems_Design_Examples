----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2022 12:28:02 PM
-- Design Name: 
-- Module Name: UART_tx_ctrl - Behavioral
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

entity UART_tx_ctrl is
--  Port ( );
generic(baud : integer := 9600);
port(send   : in std_logic;
     clk    : in std_logic;
     data   : in std_logic_vector (7 downto 0);
     ready  : out std_logic;
     uart_tx: out std_logic);
end UART_tx_ctrl;

architecture Behavioral of UART_tx_ctrl is

constant baud_timer :   integer := 100000000/baud;
constant bit_index_max: integer := 10;

type state_type is (IDLE, LOAD_BIT, SEND_BIT);

signal state    :   state_type := IDLE;
signal timer    :   integer := 0;
signal txData   : std_logic_vector(9 downto 0);
signal bitIndex : integer range 0 TO bit_index_max;
signal txBit    : std_logic := '1';

begin
process(clk)
begin
if rising_edge(clk) then

case state is
when IDLE =>
    if (send = '1')then
        txData <= '1' & data & '0';
        state <= LOAD_BIT;
    end if;
    timer <= 0;
    txBit <= '1';
when LOAD_BIT =>
    state <= SEND_BIT;
    bitIndex <= bitIndex + 1;
    txBit <= txData(bitIndex);
when SEND_BIT =>    
    if(timer = baud_timer) then
        timer <= 0;
        if(bitIndex >= bit_index_max)then
            state <= IDLE;
        else
            state <= LOAD_BIT;    
    end if;            
     else 
        timer <= timer + 1;
    end if;    
end case;
end if;
end process;
uart_tx <= txBit;
ready <= '1' when (state = IDLE) else '0';
end Behavioral;
