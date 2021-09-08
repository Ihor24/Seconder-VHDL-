--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : Arquitectura_FSM_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Tue Dec  8 13:11:22 2020
-- Last update : Thu Dec 10 12:59:21 2020
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

entity Arquitectura_FSM_tb is

end entity Arquitectura_FSM_tb;

-----------------------------------------------------------

architecture testbench of Arquitectura_FSM_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal CLK        : std_logic;
	signal RST        : std_logic;
	signal Lapso      : std_logic;
	signal Actualizar : std_logic;

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		CLK <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		CLK <= '0';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
	end process CLK_GEN;

	RESET_GEN : process
	begin
		RST <= '1';
		Lapso <= '0';
		wait for 10 mS;
		RST <= '0';
		wait for 10 mS;
		Lapso <= '1';
		wait for 10 mS;
		Lapso <= '0';
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Arquitectura_FSM
		port map (
			CLK        => CLK,
			RST        => RST,
			Lapso      => Lapso,
			Actualizar => Actualizar
		);

end architecture testbench;