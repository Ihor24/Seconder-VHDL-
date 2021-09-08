--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : Registro_FSM_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Tue Dec  8 13:12:54 2020
-- Last update : Fri Dec 11 14:05:16 2020
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2020 User Company Name
-------------------------------------------------------------------------------
-- Description: 
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity Registro_FSM_tb is

end entity Registro_FSM_tb;

-----------------------------------------------------------

architecture testbench of Registro_FSM_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal CLK         : std_logic;
	signal RST         : std_logic;
	signal Lapso       : std_logic;
	signal En_1Hz      : std_logic;
	signal En_1KHz     : std_logic;
	signal leds        : std_logic_vector (7 downto 0);
	signal Sel_displays : std_logic_vector (3 downto 0);
	signal Seg7_code   : std_logic_vector (7 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS
	constant C_En_1KHz_PERIOD : real := 10.0e-7;
	constant C_En_1Hz_PERIOD : real := 10.0e-4;

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		clk <= '0';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
	end process CLK_GEN;

	En_1KHz_GEN : process
        begin
            En_1KHz <= '1';
            wait for C_En_1KHz_PERIOD / 2.0 * (1 SEC);
            En_1KHz <= '0';
            wait for C_En_1KHz_PERIOD / 2.0 * (1 SEC);
        end process En_1KHz_GEN;

    En_1Hz_GEN : process
        begin
            En_1Hz <= '1';
            wait for C_En_1Hz_PERIOD / 2.0 * (1 SEC);
            En_1Hz <= '0';
            wait for C_En_1Hz_PERIOD / 2.0 * (1 SEC);
        end process En_1Hz_GEN;

	RESET_GEN : process
	begin
		RST <= '1';
		Lapso <= '0';
		wait for 5 mS;
		RST <= '0';
		wait for 10 mS;
		wait for 30 mS;
		Lapso <= '1';
        wait for 10 mS;
        Lapso <= '0';
        wait for 10 mS;
        Lapso <= '1';
        wait for 10 mS;
        Lapso <= '0';
        wait for 20 mS;
        RST <= '1';
        wait for 10 mS;
        RST <= '0';
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Registro_FSM
		port map (
			CLK         => CLK,
			RST         => RST,
			Lapso       => Lapso,
			En_1Hz      => En_1Hz,
			En_1KHz     => En_1KHz,
			leds        => leds,
			Sel_displays => Sel_displays,
			Seg7_code   => Seg7_code
		);

end architecture testbench;