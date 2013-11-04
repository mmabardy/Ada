-- This program will approximate values with powers of 2.
WITH ada.text_io; USE ada.text_io;
WITH ada.integer_Text_io; USE ada.integer_text_io;
WITH ada.float_Text_io; USE ada.float_text_io;
WITH unchecked_conversion;

PROCEDURE approx IS

	FUNCTION Convert IS NEW Unchecked_Conversion(Source => Float, Target => Integer);

	X, Error, Sum, Poweroftwo, leftovers: Float;
	Y, binaryconversion: Integer;

BEGIN
	while (not end_of_file) loop
		-- Read input
		get(X);
		get(Y);
		put("(x, y) = (");
		put(X,1, 25, 0);
		put(", ");
		put(y, width => 3);
		put(")");
		new_line;
		Poweroftwo := 1.0;
		Leftovers := X;
		Sum := 0.0;
		error := 0.0;
	  
		-- Check if x is in the range of 0.0 - 1.0
		IF X <= 0.0 OR X >= 1.0 THEN
			put(X, 1, 9, 0);
			put(" is not valid for X");
			new_line(1);
			goto endofline;
		END IF;
		
		--Check if y is in the range of 1 - 40
		IF Y < 0 OR Y > 40 THEN
			put(Y);
			put(" is not valid for Y");
			new_line(1);
			goto endofline;
		END IF;

		-- Loop from 1 to Y attempting to approximate x
		FOR I IN 1 .. Y LOOP
			IF Poweroftwo * 0.5 <= Leftovers THEN
				Poweroftwo := Poweroftwo * 0.5;
				put("-");
				put(I, Width => 0);
				put("        ");
				put(Poweroftwo, 1, 25, 0);
				binaryconversion:= Convert(Poweroftwo);
				put("    ");
				put(binaryconversion, base => 2);
				new_line(1);
				Leftovers := Leftovers - Poweroftwo;
				Sum := Sum + Poweroftwo;
			ELSE
				Poweroftwo := Poweroftwo * 0.5;
			END IF;
		END LOOP;
		
		--Formatting and printing of output
		put_line("   -------------------------------------");
		put("Sum      :");
		put(Sum, 1, 25, 0);
		put("    ");
		put(binaryconversion, base => 2);
		new_line;
		put("x        :");
		put(X, 1, 25, 0);
		put("    ");
		put(binaryconversion, base => 2);
		new_line;
		Put_Line("   -------------------------------------");
		Error := X - Sum;
		put("Error    :");
		put(Error, 1, 25, 0);
		new_line;
		
		--Notify user of error regarding input
		IF Error = 0.0 THEN
			put("Sum = x");
			new_line;
		ELSIF Error < 0.0 OR Error > 0.0 THEN
			put("Sum != x");
			new_line;
		END IF;
		
		--Seperate results from next pair
		<<endofline>>
		put_line("   **************************************");
	end loop;
end approx;
