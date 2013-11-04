--This program grades, takes in a file containing the number of grades
--and the weight of each grade set. Then it takes in separate students
--and every grade that the student has made or missed. Then the program
--processes the grades and prints them out in a specific order


WITH Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;
USE Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

PROCEDURE grades IS
   MAXSIZE : CONSTANT Natural := 100; -- max size of an Array

   -- Scores is an array type used to score a set of scores
   TYPE Scores IS ARRAY (Integer RANGE <>) OF Float;

   -- Record used to store the grade numbers and weights
   TYPE GradeWeight IS
      RECORD
         NumPrograms : Natural;
         WPrograms   : Float;
         NumQuiz     : Natural;
         WQuiz       : Float;
         NumTests    : Natural;
         WTests      : Float;
         NumFin      : Natural;
         Wfinal      : Float;
      END RECORD;

   -- Record used to store a student and his/her grades
   TYPE Student IS
      RECORD
         NameOfStudent : String (1 .. 20);
         NameLen       : Natural;
         ProgramsArr   : Scores (1 .. 10);
         QuizArr       : Scores (1 .. 10);
         TestArr       : Scores (1 .. 10);
         ProgramsAvg   : Float;
         QuizAvg       : Float;
         TestAvg       : Float;
         FinalGrd      : Float;
         LetterGrade   : Character;
         TotalAverage  : Float;
      END RECORD;

   -- an array of students
   TYPE StudentArray IS ARRAY (1 .. MAXSIZE) OF Student;

   -- getgradeset gets all the ne ssesary numbers for the weights and number
   -- of grades..... done cheaply
   FUNCTION GetGradeSet RETURN GradeWeight IS
      GradeW : GradeWeight;
      Nprogs : Natural;
      Wprogs : Float;
      Nquiz  : Natural;
      Wquiz  : Float;
      Ntests : Natural;
      Wtests : Float;
      Nfin   : Natural;
      Wfin   : Float;
   BEGIN
      Get(Nprogs); -- way to many gets at once!
      Get(Wprogs);
      Get(Nquiz);
      Get(Wquiz);
      Get(Ntests);
      Get(Wtests);
      Get(Nfin);
      Get(Wfin);
      GradeW.NumPrograms := Nprogs;
      GradeW.WPrograms := WProgs;
      GradeW.NumQuiz := Nquiz;
      GradeW.WQuiz := Wquiz;
      GradeW.NumTests := Ntests;
      GradeW.Wtests := Wtests;
      GradeW.NumFin := Nfin;
      GradeW.Wfinal := Wfin;

      RETURN GradeW;
   END GetGradeSet;

   -- my attempt at making a getter for a whole set of students
   FUNCTION GetStudent RETURN Student IS
      Stude : Student;          -- new student to be output
      X     : Float;            -- a natural for getting grades
      Len   : Natural;          -- The length of the name
      C     : Character;        -- the look_ahead character
      EOL   : Boolean;          -- END OF LINE BOOLEAN
      Name  : String (1 .. 20); --name of student
      programs : Scores(1..10); --array of program grades
   BEGIN
      Get_Line(Name, Len); -- get the name
      Stude.NameOfStudent := Name;  -- set name
      Stude.NameLen := Len; -- set length
--      Look_Ahead(c, EOL);
--      IF EOL THEN
--         Skip_Line;
--      ELSE
--         FOR I IN 1..10 LOOP
--         Get(X);
--         programs(i) := x;
--         END LOOP;
--      END IF;

      RETURN Stude;
   END GetStudent;

   -- my attempt at creating my own get line... i ran out of time
   PROCEDURE MyGetLine (Students: OUT StudentArray;
       GradeSet: OUT GradeWeight; InCount: IN OUT Natural) IS
      Stu : Student;
   BEGIN
      GradeSet := GetGradeSet;

      WHILE NOT End_Of_File LOOP     -- continuously get students till EOF
         Stu := GetStudent;    -- SET STUDENT
         Students(inCount) := Stu; -- set the student into the array
         inCount := inCount + 1; -- increase count for array purpose
      END LOOP;

   END MyGetLine;
      -- calculateGrades would normally calculate all of the grades avgs
      PROCEDURE CalculateGrades(S: IN OUT StudentArray) IS
      BEGIN
         FOR I IN 1..S'Length LOOP
            IF S(I).TotalAverage >= 90.0 THEN
               S(I).LetterGrade := 'A';
            END IF;
            IF S(I).TotalAverage >= 80.0 THEN
               S(I).LetterGrade := 'B';
            END IF;
            IF S(I).TotalAverage >= 70.0 THEN
               S(I).LetterGrade := 'C';
            END IF;
            IF S(I).TotalAverage >= 60.0 THEN
               S(I).LetterGrade := 'D';
            ELSE
               S(I).LetterGrade := 'F';
            END IF;

         END LOOP;
      END CalculateGrades;
   -- puts all of the students in the array
   PROCEDURE PutStudents (S : IN StudentArray; GradeSet: IN GradeWeight;
      inCount: IN Natural) IS
   BEGIN
      FOR I IN 1..4 LOOP -- loop for the array of students
        
		  -- put the name
		 Put("Name: ");
         Put(S(I).NameOfStudent(1..4));
         New_Line;

		 -- put the overall average
         Put("Overall Average: ");
         Put(S(I).TotalAverage, 1);
         New_Line;

		 -- put the letter grade
         Put("Letter Grade: ");
         Put(S(I).LetterGrade);
         New_Line;

		 -- put the headers for the columns
         Put("Category");
         Set_Col(15);
         Put("Weight Missing  Average Points");
         New_Line;

		 -- display all of the program grades
         Put("Programs");
         Set_Col(15);
         Put(GradeSet.Wprograms, 1);
         --Put(S(I).ProgramsAvg);
         New_Line;

		 -- display all of the quiz grades
         Put("Quizzes");
         Set_Col(15);
         New_Line;

		 -- display all of the test grades
         Put("Tests");
         Set_Col(15);
         New_Line;

		 --display final exam grade
         Put("Final Exam");
         New_Line;
         New_Line;
      END LOOP;

   END PutStudents;




   Students : StudentArray;
   GradeSet: GradeWeight;
   inCount: Natural := 1;

BEGIN
   MyGetLine(Students, GradeSet, inCount);
   CalculateGrades(Students);
   PutStudents(Students, GradeSet, inCount);
END grades;
