-- Purpose: Approximate fractions in binary and floating point notation
-- Input: Pair of numbers (x,y) from standard input
-- Output: X approximated to y loops

with ada.text_io; use ada.text_io; 
with ada.integer_text_io; use ada.integer_text_io; 
with ada.float_text_io; use ada.float_text_io; 
with unchecked_conversion;

procedure floating is

	-- This procedure checks if the numbers input are within the range specified
	-- x is valid if it is between 0.0 and 1.0, y is valid if it is positive and less than 40
	-- a is the input x value and b is the input y value
	-- If the numbers are within the range, xValid and yValid are returned as true
	procedure checkRange(a: float;b: integer; xValid, yValid: in out boolean) is
	begin
	
		-- checks if x is valid
		if not xValid then
			put(a, fore => 1, aft => 9, exp => 0);
			put(" is not valid for x");
			new_line;
		end if;
		
		-- checks if y is valid
		if not yValid then
			put(b);
			put(" is not valid for y");
			new_line;
		end if;
	end checkRange;

	-- Bitstring array of integers type 
	type BitString is array(1 .. 32) of Integer range 0 .. 1;
        for BitString'component_size use 1;-- One bit per array element
		for BitString'size use 32;         -- 32 bits for the entire array
		for BitString'alignment use 4;     -- Variables aligned on a 4 byte boundary.
	
	function convert is new unchecked_conversion(source => float, target => integer);
	
	function copy_bits is new unchecked_conversion(source => float, target => BitString);
	
	-- This function uses Horner's method to approximate the decimal value of a binary number
	function horners_method(array_to_convert: in BitString) return integer is
		decimal, twoRep: integer := 0;
	begin
		twoRep := 1;
		for i in reverse 25 .. 32 loop
			decimal := decimal + (array_to_convert(i) * twoRep);
			twoRep := twoRep * 2; 
		end loop;
		return decimal;
	end horners_method;
	
	-- This procedure will print out the + or - sign depending on sign bit
	procedure print_sign(sign_bit: in integer) is
	begin
		if sign_bit = 0 then
			put("+");
		else
			put("-");
		end if;
	end print_sign;
	
	-- This procedure will output the binary representation and exponent representation
	procedure print_binary(print_value: in float) is
		binary: integer;
		decimal: integer;
		biased: float := 0.0;
		binary_array: BitString;
		exponent_array: BitString := (others => 0);
		i: integer := 25;
	begin   
		put(print_value, fore => 1, aft => 25, exp => 0);
		binary := convert(print_value);
		put("  ");
		put(binary, base => 2);
		put("  ");
		binary_array := copy_bits(print_value);
		-- Check the sign bit and output accordingly
		print_sign(binary_array(32));
		-- Transfer exponent bits into separate array to convert to decimal
		for k in reverse 24 .. 31 loop
			exponent_array(i) := binary_array(k);
			i := i + 1;
		end loop;
		decimal := (horners_method(exponent_array) - 127);
		if decimal = -127 then
			put("0.");
			-- Prints the bits as they are
			for j in reverse 1 .. 23 loop
				put(binary_array(j), width => 0); 
			end loop;
		else
			put("1.");
			-- Ditto
			for j in reverse 1 .. 23 loop
				put(binary_array(j), width => 0); 
			end loop;
			put(" X 2^  ");
			put(decimal, width => 0);
		end if;
		new_line;
	end print_binary;
	
	-- This procedure will output the x and y pair
	procedure print_initial(a: in float; b: in integer) is 
	begin
		put("(x, y) = (");
		put(a, fore => 1, aft => 25, exp => 0);
		put(", ");
		put(b, width => 0);
		put(")");
		new_line;
	end print_initial;
	
	-- This procedure will sum the values of powers up to y
	function calc_sum_powers(x: float; y: integer) return float is
		leftover: float := x;    -- Amount left over from first powers of two subtraction
		twoPower: float := 1.0;  -- The negative powers of two quantity
		sum: float := 0.0;       -- Sum of the negative powers of two
	begin
		for i in 1 .. y loop
			if twoPower/2.0 <= leftover then
				twoPower := twoPower/2.0;
				put("  -");
				put(i, width => 0);
				put("    ");
				print_binary(twoPower);
				leftover := leftover - twoPower;
				sum := sum + twoPower;
			else
				twoPower := twoPower/2.0;
			end if;
		end loop;
		return sum;
	end calc_sum_powers;
	
	y: integer range 0 .. 39;
	x: float range float'adjacent(0.0, 0.1) .. float'adjacent(1.0, 0.9);
	error: float;               -- Amount of error as defined by "x - sum"
	sum: float;                 -- Sum of the negative powers of two
	xValid, yValid: boolean;    -- Used to determine incorrect input
	
	
	begin
	-- Loop until end of file is received
	while (not End_Of_File) loop
		get(x);             -- Retrieves first (float) value and stores in x
		get(y);             -- Retrieves second (integer) value and stores in y
		print_initial(x, y);-- Prints the initial line(x, y) 
		xValid := 0.0 < x and x < 1.0;
		yValid := 0 <= y and y < 40;
		checkRange(x, y, xValid, yValid);
		
		-- Checks if the inputs (x,y) are in the valid range
		if xValid and yValid then		
			-- Intialize variables 
			error := 0.0; 
			sum := calc_sum_powers(x, y);
			put_line("       -----------------------------------");
			put("Sum   : ");
			print_binary(sum);
			put("x     : ");
			print_binary(x);
			put_line("       -----------------------------------");
			error := x - sum;
			put("Error : ");
			print_binary(error);
			if error = 0.0 then 
				put("Sum = x");
				new_line;
			elsif error < 0.0 OR error > 0.0 then
				put("Sum /= x");
				new_line;
			end if; 
		end if;		
	end loop;
	
	-- Exception handling
	exception
        when data_error => put_line("Non-numeric data in input.  Execution halted.");
        when end_error => put_line("Premature end of file.  Execution halted.");
        when constraint_error => put_line("Invalid number entered. Execution halted.");
	
end floating;
