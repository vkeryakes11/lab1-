library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_top is
    Port ( 
        clk : in std_logic;
        btn, sw : in std_logic_vector(3 downto 0);
        led : out std_logic_vector(3 downto 0)
    );
end counter_top;

architecture structure of counter_top is

component clock_div is
    Port (
        clk : in std_logic;
        div : out std_logic
        );
    end component;

component debounce is
    Port(

        clk : in std_logic;
        btn : in std_logic;
        dbnc : out std_logic

    );
    end component;

component fancy_counter is 
    Port ( 
        clk : in std_logic;
        clk_en : in std_logic;
        dir : in std_logic;
        en : in std_logic;
        ld : in std_logic;
        rst : in std_logic;
        updn : in std_logic;
        val : in std_logic_vector(3 downto 0);
        cnt : out std_logic_vector(3 downto 0)

    );
end component;

signal dbnc, cnt_out : std_logic_vector(3 downto 0);
signal div_out : std_logic;
begin

    U5 : clock_div
    port map(
        clk => clk,
        div => div_out
    );

    U1 : debounce
    port map(
        clk => clk, 
        btn => btn(0),
        dbnc => dbnc(0)
    );

     U2 : debounce
    port map(
        clk => clk, 
        btn => btn(1),
        dbnc => dbnc(1)
    );

     U3 : debounce
    port map(
        clk => clk, 
        btn => btn(2),
        dbnc => dbnc(2)
    );

     U4 : debounce
    port map(
        clk => clk, 
        btn => btn(3),
        dbnc => dbnc(3)
    );

    U6 : fancy_counter
    port map ( 
        clk => clk,
        clk_en => div_out,
        dir => sw(0), 
        en => dbnc(1),
        ld => dbnc(3), 
        rst => dbnc(0),
        updn => dbnc(2),
        val => sw,
        cnt => cnt_out

    );

    led <= cnt_out; 
end structure;


