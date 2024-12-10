----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.09.2024 17:42:51
-- Design Name: 
-- Module Name: signal_mux - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity signal_mux is
   generic(
   constante_ref: integer := 128); --8 bits constant por defecto 128 que son 0.5V para XADC
 
    Port (
       -- signal_A : IN std_logic_vector(7 DOWNTO 0);  --VALOR DE REFERENCIA CONSTANTE VOLTAJE DC 
        --en_A : IN std_logic;
        signal_B : IN std_logic_vector(7 DOWNTO 0);  --SEÑAL NEUTRINOS FILTRADA
        --en_B : IN std_logic;
        signal_C : IN std_logic_vector(7 DOWNTO 0);  --SEÑAL NEUTRINOS RUIDOSA
        --en_C : IN std_logic;
        signal_D : IN std_logic_vector(7 DOWNTO 0);  --SEÑAL NEUTRINOS
        --en_D : IN std_logic;
        signal_E : IN std_logic_vector(7 DOWNTO 0);  --TRANSF_Z EXPONENCIAL
        --en_E : IN std_logic;
        
        SEL : IN std_logic_vector(2 downto 0);       --SELECTOR
        ENABLE : out std_logic;
        S_OUT : OUT std_logic_vector(7 downto 0)  
    );
end signal_mux;

architecture Behavioral of signal_mux is

begin
    process(SEL)
    
        begin case SEL is  
            when "001" =>
                S_OUT <= std_logic_vector(to_unsigned(constante_ref,8));  
                ENABLE <= '1';
            when "010" =>
                S_OUT <= signal_B;
                 ENABLE <= '1';
            when "011" =>
                S_OUT <= signal_C;
                 ENABLE <= '1';
            when "100" =>
                S_OUT <= signal_D;
                 ENABLE <= '1';
            when "101" =>
                S_OUT <= signal_E;
                ENABLE <= '1';
            when others =>
                S_OUT <= "00000000";
                ENABLE <= '1';
        end case;
        
    
    end process;

end Behavioral;
