LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sipo IS
	PORT(reset_n, Clk : IN STD_LOGIC;
		  Data_in : IN STD_LOGIC;
		  Q : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0));
END sipo;

ARCHITECTURE Behavior OF sipo IS
BEGIN
	PROCESS ( reset_n, Clk)
	BEGIN
		IF(reset_n = '0') THEN
			Q <= "0000";
		ELSIF (Clk'EVENT AND Clk = '1') THEN
			Q(0) <= Q(1);
			Q(1) <= Q(2);
			Q(2) <= Q(3);
			Q(3) <= Data_in;
		END IF;
	END PROCESS;
END Behavior;
