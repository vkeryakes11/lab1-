
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fancy_counter_tb is
end fancy_counter_tb;

architecture testbench of fancy_counter_tb is

    signal tb_clk   : std_logic := '0';
    signal tb_rst   : std_logic := '0';
    signal tb_en    : std_logic := '0';
    signal tb_clk_en: std_logic := '0';
    signal tb_ld    : std_logic := '0';
    signal tb_val   : std_logic_vector(3 downto 0) := "0000";
    signal tb_updn  : std_logic := '0';
    signal tb_dir   : std_logic := '0';
    signal tb_cnt   : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 8 ns;

    component fancy_counter is
        port (
            clk    : in std_logic;
            rst    : in std_logic;
            en     : in std_logic;
            clk_en : in std_logic;
            ld     : in std_logic;
            val    : in std_logic_vector(3 downto 0);
            updn   : in std_logic;
            dir    : in std_logic;
            cnt    : out std_logic_vector (3 downto 0)
        );
    end component;

begin

    -- Instantiate the fancy counter
    uut: fancy_counter
    port map (
        clk    => tb_clk,
        rst    => tb_rst,
        en     => tb_en,
        clk_en => tb_clk_en,
        ld     => tb_ld,
        val    => tb_val,
        updn   => tb_updn,
        dir    => tb_dir,
        cnt    => tb_cnt
    );

    -- Clock generation process for 125 MHz
    clk_gen_proc: process
    begin
        while now < 1 us loop  -- Simulate for 1 microsecond
            tb_clk <= '0';
            wait for CLK_PERIOD / 2;
            tb_clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        report "Clock generation complete. Simulation stopping." severity note;
        std.env.stop;
    end process clk_gen_proc;

    -- Stimulus process to test counter behavior
    stimulus_proc: process
    begin
        -- Reset counter
        tb_rst <= '1';
        wait for 16 ns;
        tb_rst <= '0';
        
        -- Enable counting up
        tb_en <= '1';
        tb_clk_en <= '1';
        tb_updn <= '1';
        tb_dir <= '1';
        wait for 80 ns;
        
        -- Load a new value
        tb_ld <= '1';
        tb_val <= "0011";
        wait for 16 ns;
        tb_ld <= '0';
        
        -- Enable counting down
        tb_updn <= '0';
        wait for 80 ns;
        
        -- Stop simulation
        report "Simulation completed." severity note;
        std.env.stop;
    end process stimulus_proc;

end testbench;