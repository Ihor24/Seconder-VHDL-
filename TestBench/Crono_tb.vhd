--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : Crono_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Thu Dec 17 12:24:55 2020
-- Last update : Thu Dec 17 12:25:20 2020
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

entity Crono_tb is

end entity Crono_tb;

-----------------------------------------------------------

architecture testbench of Crono_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal CLK          : std_logic;
	signal RST          : std_logic;
	signal Lapso        : std_logic;
	signal leds         : std_logic_vector (7 downto 0);
	signal Sel_displays : std_logic_vector (3 downto 0);
	signal Seg7_code    : std_logic_vector (7 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

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

	RESET_GEN : process
	begin
		RST <= '0';
		Lapso <= '0';
		wait for 5 mS;
		RST <= '1';
		wait for 30 mS;
		Lapso <= '1';
		wait for 5 mS;
		Lapso <= '0';
		wait for 40 mS;
		Lapso <= '1';
		wait for 5 mS;
        Lapso <= '0';
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Crono
		port map (
			CLK          => CLK,
			RST          => RST,
			Lapso        => Lapso,
			leds         => leds,
			Sel_displays => Sel_displays,
			Seg7_code    => Seg7_code
		);

end architecture testbench;