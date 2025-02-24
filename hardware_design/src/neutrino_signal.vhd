library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity neutrino_signal is
    generic(
        OFFSET_VAL : integer := 0
    );
    Port( clk : in std_logic;    
          reset : in std_logic;
          pulse_trig : in std_logic;
          signalout : out std_logic_vector(7 downto 0));
          --enable_tx : out std_logic);
end neutrino_signal;

architecture Behavioral of neutrino_signal is
    type data_arr is array (0 to 629) of integer range 0 to 255; -- Corrected range for integer values
    signal data_array : data_arr := (43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,
        43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,
        43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,
        43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,
        43,  43,  43,  43,  43,  43,  43,  43,  43,  43, 105, 159, 205,
       234, 249, 255, 255, 251, 247, 242, 236, 231, 225, 220, 214, 209,
       204, 199, 194, 189, 184, 180, 175, 171, 166, 162, 158, 154, 150,
       146, 142, 138, 135, 131, 127, 124, 121, 117, 114, 111, 108, 105,
       102,  99,  96,  94,  91,  88,  86,  83,  81,  78,  76,  74,  71,
        69,  67,  65,  63,  61,  59,  57,  55,  54,  52,  50,  49,  47,
        45,  44,  42,  41,  39,  38,  37,  35,  34,  33,  32,  30,  29,
        28,  27,  26,  25,  24,  23,  22,  21,  20,  19,  18,  18,  17,
        16,  15,  15,  14,  13,  13,  12,  11,  11,  10,  10,   9,   8,
         8,   8,   7,   7,   6,   6,   5,   5,   5,   4,   4,   4,   3,
         3,   3,   3,   2,   2,   2,   2,   1,   1,   1,   1,   1,   1,
         0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
         0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
         0,   0,   0,   0,   0,   0,   0,   1,   1,   1,   1,   1,   1,
         1,   1,   2,   2,   2,   2,   2,   2,   2,   3,   3,   3,   3,
         3,   3,   4,   4,   4,   4,   4,   4,   5,   5,   5,   5,   5,
         6,   6,   6,   6,   6,   7,   7,   7,   7,   7,   8,   8,   8,
         8,   8,   9,   9,   9,   9,  10,  10,  10,  10,  10,  11,  11,
        11,  11,  11,  12,  12,  12,  12,  13,  13,  13,  13,  13,  14,
        14,  14,  14,  15,  15,  15,  15,  15,  16,  16,  16,  16,  17,
        17,  17,  17,  17,  18,  18,  18,  18,  18,  19,  19,  19,  19,
        20,  20,  20,  20,  20,  21,  21,  21,  21,  21,  22,  22,  22,
        22,  22,  23,  23,  23,  23,  23,  24,  24,  24,  24,  24,  25,
        25,  25,  25,  25,  25,  26,  26,  26,  26,  26,  27,  27,  27,
        27,  27,  27,  28,  28,  28,  28,  28,  28,  29,  29,  29,  29,
        29,  29,  30,  30,  30,  30,  30,  30,  31,  31,  31,  31,  31,
        31,  31,  32,  32,  32,  32,  32,  32,  33,  33,  33,  33,  33,
        33,  33,  33,  34,  34,  34,  34,  34,  34,  34,  35,  35,  35,
        35,  35,  35,  35,  35,  36,  36,  36,  36,  36,  36,  36,  36,
        37,  37,  37,  37,  37,  37,  37,  37,  37,  38,  38,  38,  38,
        38,  38,  38,  38,  38,  39,  39,  39,  39,  39,  39,  39,  39,
        39,  39,  39,  40,  40,  40,  40,  40,  40,  40,  40,  40,  40,
        40,  41,  41,  41,  41,  41,  41,  41,  41,  41,  41,  41,  41,
        42,  42,  42,  42,  42,  42,  42,  42,  42,  42,  42,  42,  42,
        42,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,  43,
        43,  43,  43,  43,  43,  44,  44,  44,  44,  44,  44,  44,  44,
        44,  44,  44,  44,  44,  44,  44,  44,  44,  44,  44,  45,  45,
        45,  45,  45,  45,  45,  45,  45,  45,  45,  45,  45,  45,  45,
        45,  45,  45,  45,  45,  45,  45,  45,  45,  46,  46,  46,  46,
        46,  46,  46,  46,  46,  46,  46,  46,  46,  46,  46,  46,  46,
        46,  46,  46,  46,  46,  46,  46,  46,  46,  46,  46,  46,  46,
        46,  46,  46,  46,  47,  47,  47,  47,  47,  47,  47,  47,  47,
        47,  47,  47,  47,  47,  47,  47,  47,  47,  47,  47,  47,  47,
        47,  47,  47,  47,  47,  47,  47,  47,  47,  47,  47,  47,  47,
        47,  47,  47,  47,  47,  47);
    signal index : integer := 629; -- Index that traverses the array

begin

    process(clk, reset, pulse_trig)
    begin
        if reset = '0' then
            --index <= 0;
            signalout <= (others => '0');
            
            
        elsif rising_edge(clk) then
           -- enable_tx <= '1';
            if pulse_trig = '1' then
                
                index <= 0;
                signalout <= conv_std_logic_vector(data_array(index), 8);
            
            else
                if index = 629 then
                        signalout <= conv_std_logic_vector(OFFSET_VAL, 8);
                
                else
                    signalout <= conv_std_logic_vector(data_array(index), 8);
                    index <= index + 1;  
                    
                end if;
                        
            end if;

    end if;  
    end process;

end Behavioral;
