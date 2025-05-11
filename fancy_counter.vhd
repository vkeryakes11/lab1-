library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fancy_counter is
    Port (
        clk    : in  STD_LOGIC;                      -- Clock input
        rst    : in  STD_LOGIC;                      -- Reset
        en     : in  STD_LOGIC;                      -- Enable counting
        clk_en : in  STD_LOGIC;                      -- Clock enable
        ld     : in  STD_LOGIC;                      -- Load enable
        val    : in  STD_LOGIC_VECTOR(3 downto 0);   -- Value to load
        updn   : in  STD_LOGIC;                      -- Up/Down control
        dir    : in  STD_LOGIC;                      -- Direction control
        cnt    : out STD_LOGIC_VECTOR(3 downto 0)    -- Counter output
    );
end fancy_counter;

architecture Behavioral of fancy_counter is
    signal count1,value : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal direction : STD_LOGIC := '0';
begin

   process (clk)
begin
    if rising_edge(clk) and en='1' then
        if rst = '1' then
             count1 <= "0000";
        end if;
        if en = '1' and clk_en = '0' then
           if rst = '1' then
                count1 <= "0000"; end if;
        elsif en = '1' and clk_en = '1' then
            if rst = '1' then
             count1 <= "0000"; end if;
             
            if updn = '1' then
                direction <= dir;  -- Update direction
            end if;
            if ld = '1' then
               value<= val;
            end if;

            if direction = '1' then  -- Counting UP
                if count1 = value then
                    count1 <= "0000"; 
                    
                else
                    count1 <= std_logic_vector(unsigned(count1) + 1) ;
                end if;
            else  
                if count1 = "0000" then
                    count1 <= value;  
                    
                else
                    count1 <= std_logic_vector(unsigned(count1) - 1) ;
                end if;
             end if;
           end if;
        end if;
    
end process;


  cnt <= count1;  

end Behavioral;
