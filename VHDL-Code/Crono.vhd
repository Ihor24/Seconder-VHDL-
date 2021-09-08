library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Crono is

	port (
			CLK : in std_logic;
			RST : in std_logic;
			Lapso : in std_logic;
			leds : out std_logic_vector (7 downto 0);
			Sel_displays : out std_logic_vector (3 downto 0); 
			Seg7_code : out std_logic_vector (7 downto 0));
	
end entity Crono;

architecture rtl of Crono is

	component Registro_FSM is
		port (
			CLK : in std_logic;
			RST : in std_logic;
			Lapso : in std_logic;
			En_1Hz : in std_logic;
			En_1KHz : in std_logic;
			leds : out std_logic_vector (7 downto 0);
			Sel_displays : out std_logic_vector (3 downto 0); 
			Seg7_code : out std_logic_vector (7 downto 0));

	end component Registro_FSM;

	component reloj is
		port (
			CLK : in std_logic; --Se?l de reloj
      		RST : in std_logic; --Se?l de reset
      		En_1Hz : out std_logic; --Frecuencia para contar segundos
      		En_1KHz : out std_logic); --Frecuencia para display

	end component reloj;

	signal En_1KHz : std_logic;
	signal En_1Hz : std_logic;

begin


	Clock : reloj
		port map (
			CLK => CLK,
			RST => RST,
			En_1KHz => En_1KHz,
			En_1Hz => En_1Hz);

	Reg_FSM : Registro_FSM
		port map (
			CLK => CLK,
			RST => RST,
			Lapso => Lapso,
			En_1KHz => En_1KHz,
			EN_1Hz => En_1Hz,
			leds => leds,
			Sel_displays => Sel_displays,
			Seg7_code => Seg7_code);

end architecture ; -- rtl