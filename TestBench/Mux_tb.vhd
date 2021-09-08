--------------------------------------------------------------------------------
-- Title       : <Title Block>
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : Mux_tb.vhd
-- Author      : User Name <user.email@user.company.com>
-- Company     : User Company Name
-- Created     : Thu Dec 10 13:41:12 2020
-- Last update : Thu Dec 10 17:13:18 2020
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

entity Mux_tb is

end entity Mux_tb;

-----------------------------------------------------------

architecture testbench of Mux_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal CLK          : std_logic;
	signal RST          : std_logic;
	signal unidades     : std_logic_vector (3 downto 0);
	signal decenas      : std_logic_vector (3 downto 0);
	signal En_1KHz      : std_logic;
	signal Seg7_code    : std_logic_vector (7 downto 0);
	signal Sel_displays : std_logic_vector (3 downto 0);

	-- Other constants
	constant C_CLK_PERIOD : real := 10.0e-9; -- NS
	constant C_En_1KHz_PERIOD : real := 10.0e-6;

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

	RESET_GEN : process
	begin
	    unidades <= "0000";
        decenas <= "0000";
		RST <= '1';
		wait for 10 mS;
		RST <= '0';
		unidades <= "0101";
		decenas <= "0010";
		wait for 10 mS;
		unidades <= "0001";
		decenas <= "0100";
		wait for 10 mS;
		unidades <= "0101";
		decenas <= "0110";
		wait for 10 mS;
		unidades <= "0000";
        decenas <= "0000";
		
		wait;
	end process RESET_GEN;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Mux
		port map (
			CLK          => CLK,
			RST          => RST,
			unidades     => unidades,
			decenas      => decenas,
			En_1KHz      => En_1KHz,
			Seg7_code    => Seg7_code,
			Sel_displays => Sel_displays
		);

end architecture testbench;