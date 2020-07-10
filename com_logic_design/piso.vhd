LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY piso IS
	PORT(reset_n, Clk : IN STD_LOGIC;
		  L : IN STD_LOGIC;
		  D : IN STD_LOGIC_VECTOR(0 TO 3);
		  Q : BUFFER STD_LOGIC_VECTOR(0 TO 3));
END piso;

ARCHITECTURE Behavior OF piso IS
BEGIN
	PROCESS ( reset_n, Clk)
	BEGIN
		IF(reset_n = '0') THEN
			Q <= "0000";
		ELSIF (Clk'EVENT AND Clk = '1') THEN
			IF L = '0' THEN
				Q <= D;
			ELSE
				Q(0) <= '0';
				Q(1) <= Q(0);
				Q(2) <= Q(1);
				Q(3) <= Q(2);
			END IF;
		END IF;
	END PROCESS;
END Behavior;
