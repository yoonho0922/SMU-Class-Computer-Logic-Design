library ieee; use ieee.std_logic_1164.all;

ENTITY bit_adder IS
	PORT(reset_n, Clk : IN STD_LOGIC;
		  START : IN STD_LOGIC;
		  A, B : IN STD_LOGIC_VECTOR(0 TO 3);
		  DONE : OUT STD_LOGIC;
		  L, QS : BUFFER STD_LOGIC;
		  QA, QB, SUM : BUFFER STD_LOGIC_VECTOR(0 TO 3));
END bit_adder;

architecture a of bit_adder is
component piso PORT(reset_n, Clk : IN STD_LOGIC;
						  L : IN STD_LOGIC;
						  D : IN STD_LOGIC_VECTOR(0 TO 3);
						  Q : BUFFER STD_LOGIC_VECTOR(0 TO 3));
END component;
component sipo PORT(reset_n, Clk : IN STD_LOGIC;
						  Data_in : IN STD_LOGIC;
						  Q : BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0));
END component;
component serial_adder PORT (	Clk : IN STD_LOGIC;
										reset_n : IN STD_LOGIC;
										A, B : IN STD_LOGIC;
										S : OUT STD_LOGIC );
END component;
	TYPE s IS (S0, S1, S2);
	TYPE d IS (S0,S1,S2,S3,S4,S5);
	SIGNAL s_state : s;
	SIGNAL d_state : d;
BEGIN
	PISO_01 : piso port map(reset_n => reset_n, Clk => Clk,
									L => L, D => A, Q => QA);
	PISO_02 : piso port map(reset_n => reset_n, Clk => Clk,
									L => L, D => B, Q => QB);
	SA : serial_adder port map(reset_n => reset_n, Clk => Clk,
										A => QA(3), B => QB(3), S => QS);
	SIPO_01 : sipo port map(reset_n => reset_n, Clk => Clk,
									Data_in => QS, Q => SUM);		
	
	--about START
	PROCESS (reset_n, Clk)
	BEGIN
		IF reset_n = '0' THEN
			s_state <= S0;
		ELSIF (Clk'EVENT AND CLK = '1') THEN
			CASE s_state IS
				WHEN S0 =>
					IF START = '1' THEN
						s_state <= S1;
					ELSE
						s_state <= S0;
					END IF;
				WHEN S1 =>
					IF START = '1' THEN
						s_state <= S2;
					ELSE
						s_state <= S0;
					END IF;
				WHEN S2 =>
					IF START = '1' THEN
						s_state <= S2;
					ELSE
						s_state <= S0;
					END IF;
			END CASE;
		END IF;
	END PROCESS;
	L <= '0' WHEN s_state = S1 ELSE '1';
	
	--about DONE
	PROCESS (reset_n, Clk)
	BEGIN
		IF reset_n = '0' THEN
			d_state <= S0;
		ELSIF (Clk'EVENT AND CLK = '1') THEN
			CASE d_state IS
				WHEN S0 =>
					IF L = '0' THEN
						d_state <= S1;
					ELSE
						d_state <= S0;
					END IF;
				WHEN S1 =>
					d_state <= S2;
				WHEN S2 =>
					d_state <= S3;
				WHEN S3 =>
					d_state <= S4;
				WHEN S4 =>
					d_state <= S5;
				WHEN S5 =>
					d_state <= S0;					
			END CASE;
		END IF;
	END PROCESS;
	DONE <= '1' WHEN d_state = S5 ELSE '0';
	
END a;