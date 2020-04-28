LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY mux8to1 IS
	PORT (	a,b,c,d : IN STD_LOGIC;
		En : IN 	STD_LOGIC;
		f: OUT 	STD_LOGIC ) ;
END mux8to1 ;
ARCHITECTURE Behavior OF mux8to1 IS	
  signal Enabc : std_logic_vector(3 downto 0);
BEGIN
	Enabc <= En & a & b & c;
	WITH Enabc SELECT
		f <= 	not d WHEN "1000",
			'1' WHEN "1001",
			'0' WHEN "1010",
			'0' when "1011",
			not d WHEN "1100",
			'1' WHEN "1101",
			not d WHEN "1110",
			'1' when "1111",
			'0' when OTHERS;
END Behavior ;
