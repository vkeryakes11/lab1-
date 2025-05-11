library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity clock_div_tb is
end clock_div_tb;

architecture testbench of clock_div_tb is

    signal tb_clk : std_logic := '0';

    component clock_div is
        port(

            clk  : in std_logic;        -- 125 Mhz clock
            div : out std_logic 

        );
    end component;
signal tb_div : std_logic; 

begin

--------------------------------------------------------------------------------
-- procs
--------------------------------------------------------------------------------

    -- simulate a 125 Mhz clock
    clk_gen_proc: process
    begin
        loop 

            wait for 4 ns;
            tb_clk <= '1';

            wait for 4 ns;
            tb_clk <= '0';

        end loop;

    end process clk_gen_proc;



--------------------------------------------------------------------------------
-- port mapping
--------------------------------------------------------------------------------

    dut : clock_div
    port map (

        clk  => tb_clk,
        div => tb_div

    );


end testbench;

