library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registro_FSM is

	port (
			CLK : in std_logic;
			RST : in std_logic;
			Lapso : in std_logic;
			En_1Hz : in std_logic;
			En_1KHz : in std_logic;
			leds : out std_logic_vector (7 downto 0);
			Sel_displays : out std_logic_vector (3 downto 0); 
			Seg7_code : out std_logic_vector (7 downto 0));
	
end entity Registro_FSM;

architecture comportamiento of Registro_FSM is

	component Arquitectura_FSM is
		port (
			CLK : in std_logic;
			RST : in std_logic;
			Lapso : in std_logic;
			Actualizar : out std_logic);
	end component Arquitectura_FSM;

	component Mux is
		port (
			unidades : in std_logic_vector (3 downto 0);
			decenas : in std_logic_vector (3 downto 0);
			CLK : in std_logic;
			RST : in std_logic;
			En_1KHz : in std_logic;
			Seg7_code : out std_logic_vector (7 downto 0);
			Sel_displays : out std_logic_vector (3 downto 0));
	end component Mux;

	signal Actualizar_i : std_logic;
	signal unidades : std_logic_vector (3 downto 0);
	signal decenas : std_logic_vector (3 downto 0);
	signal leds_i : unsigned (7 downto 0);
	signal contunidades : unsigned (3 downto 0);
	signal contdecenas : unsigned (3 downto 0);


	begin
		
		FSM : Arquitectura_FSM
			port map (
				CLK => CLK, 
				RST => RST,
				Lapso => Lapso,
				Actualizar => Actualizar_i);

		Multiplexor : Mux
			port map (
				CLK => CLK,
				RST => RST,
				unidades => unidades,
				decenas => decenas,
				En_1KHz => En_1KHz,
				Seg7_code => Seg7_code,
				Sel_displays => Sel_displays);


	Cont_Seg : process(CLK, RST, En_1Hz) is
	begin

		if (RST = '0') then
			contdecenas <= (others => '0');
			contunidades <= (others => '0');
		elsif (En_1Hz = '1' and En_1Hz'event and CLK = '1') then
		
		contunidades <= contunidades + 1;

                if (contdecenas = "0101") then
                    contdecenas <= (others => '0');
				elsif (contunidades = "1001") then
					contdecenas <= contdecenas + 1;
					contunidades <= (others => '0');
				end if;

		end if;
		
		if (Actualizar_i = '0') then
            unidades <= std_logic_vector (contunidades);
            decenas <= std_logic_vector (contdecenas);
            leds_i <= (contdecenas & contunidades);
            leds <= std_logic_vector (leds_i);
        end if;
		
	end process Cont_Seg; -- Cont_Seg

	

end architecture comportamiento;