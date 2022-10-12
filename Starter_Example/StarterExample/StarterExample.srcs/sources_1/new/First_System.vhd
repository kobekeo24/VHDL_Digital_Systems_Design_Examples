----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2022 11:00:46 AM
-- Design Name: 
-- Module Name: First_System - Behavioral
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

entity First_System is
--  Port ( );
port(in1: in std_logic;
     in2: in std_logic;
     out1: out std_logic;
     out2: out std_logic);
end First_System;

architecture dataflow_model of First_System is
begin
out1 <= (in1 and in2) xor (in1 or in2);
out2 <= not in1;
end dataflow_model;
