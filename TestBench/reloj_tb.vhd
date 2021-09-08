--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : reloj_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Tue Dec  8 13:11:50 2020
-- Last update : Thu Dec 10 13:26:55 2020
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

entity reloj_tb is

end entity reloj_tb;

-----------------------------------------------------------

architecture testbench of reloj_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal CLK     : std_logic;
	signal RST     : std_logic;
	signal En_1Hz  : std_logic;
	signal En_1KHz : std_logic;

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
	DUT : entity work.reloj
		port map (
			CLK     => CLK,
			RST     => RST,
			En_1Hz  => En_1Hz,
			En_1KHz => En_1KHz
		);

end architecture testbench;