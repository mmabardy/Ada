--********************************************************************
--
-- This is the client that utilizes the wordpkg.pals child package
--  to test to see if a word is a palindrome or not. Loops through a
--  list of words to test and prints out the proper message to let
--  the user know if the word is a palindrome as-is or, if it was
--  modified, the steps taken to make it a plaindrome. If the word
--  is not a palindrome at all, the user is also alerted.
--********************************************************************

WITH Wordpkg; USE Wordpkg;
WITH Wordpkg.Pals; USE Wordpkg.Pals;
WITH Ada.Text_IO; USE Ada.Text_IO;

PROCEDURE pals IS
   W : Word; --Create a word object.

BEGIN

   --Loop through the input.
   WHILE NOT Ada.Text_Io.End_Of_File LOOP

      --Read in the word and print it out.
      Get(W);
      Put("String: ");
      Put(W);
      New_Line;

      ------------------------------------------
      --Tests to see if the word is a palindrome.
      ------------------------------------------

      --If word is palindrome as is, print 'as-is' status.
      IF IsPal(W) THEN
         Put_Line("Status: Palindrome as is.");

      --If word is a plaindrome once non-letters are removed
      -- print 'non-letter' status and modified palindrome.
      ELSIF IsPal(RemoveNonLetter(W)) THEN
         Put_Line("Status: Palindrome when non-letters are removed.");
         Put("PalStr: ");
         Put (RemoveNonLetter(W));
         New_Line;

      --If word is a plaindrome once converted to uppercase
      -- print 'uppercase' status and modified palindrome.
      ELSIF IsPal(ToUpper(W)) THEN
         Put_Line("Status: Palindrome when converted to upper case.");
         Put("PalStr: ");
         Put(ToUpper(W));
         New_Line;

      --If word is a plaindrome once non-letters are removed
      -- and it is put into uppercase print 'non-letter/uppercase'
      -- status and modified palindrome.
      ELSIF IsPal(RemoveNonLetter(ToUpper(W))) THEN
         Put("Status: Palindrome when converted to upper case");
         Put_Line(" and non-letters are removed.");
         Put("PalStr: ");
         Put(RemoveNonLetter(ToUpper(W)));
         New_Line;

      --Else the word is not a palindrome and print 'not-pal' statis.
      ELSE
         Put("Status: Never a palindrome");
      END IF;

      --Newlines for spacing between output of test results.
      New_Line;
      New_Line;
   END LOOP;
END pals;
