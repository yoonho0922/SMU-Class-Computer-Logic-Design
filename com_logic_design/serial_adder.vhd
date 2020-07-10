Library ieee;
USE ieee.std_logic_1164.all;

ENTITY serial_adder IS
	PORT (	Clk : IN STD_LOGIC;
            reset_n : IN STD_LOGIC;
            A, B : IN STD_LOGIC;
			   S : OUT STD_LOGIC );
END serial_adder;

ARCHITECTURE Behavior OF serial_adder IS
	TYPE State IS (S0, S1);
	SIGNAL y_present, y_next : State;
	signal AB: std_logic_vector(1 downto 0);
BEGIN
	AB <= A & B;
	PROCESS (AB, y_present)
	BEGIN
		CASE y_present IS
			WHEN S0 =>
				IF AB = "11" THEN
					y_next <= S1;
				ELSE
					y_next <= S0;
				END IF;
			WHEN S1 =>
				IF AB = "00" THEN
					y_next <= S0;
				ELSE
					y_next <= S1;
				END IF;
		END CASE;
	END PROCESS ;
	
	PROCESS(Clk, reset_n)
	BEGIN
		IF reset_n = '0' THEN
			y_present <= S0;
		ELSIF(Clk'EVENT AND Clk = '1') THEN
			y_present <= y_next;
		END IF;
	END PROCESS;
	
	S <= '1' WHEN ((y_present = S0 AND (AB = "01" OR AB ="10")) 
						OR (y_present = S1 AND (AB = "00" OR AB ="11")))
						ELSE '0';

END Behavior ;
