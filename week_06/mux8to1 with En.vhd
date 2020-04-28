LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY mux8to1 IS
	PORT (	w: IN 	STD_LOGIC_VECTOR(7 downto 0) ;
		s: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0) ;
		En : IN 	STD_LOGIC;
		f: OUT 	STD_LOGIC ) ;
END mux8to1 ;
ARCHITECTURE Behavior OF mux8to1 IS	
  signal Ens : std_logic_vector(3 downto 0);
BEGIN
	Ens <= En & s;
	WITH Ens SELECT
		f <= 	w(0) WHEN "1000",
			w(1) WHEN "1001",
			w(2) WHEN "1010",
			w(3) when "1011",
			w(4) WHEN "1100",
			w(5) WHEN "1101",
			w(6) WHEN "1110",
			w(7) when "1111",
			'0' when OTHERS;
END Behavior ;
