--********************************************************************
-- This package extends the use of the word package by creating
--  procedures and functions that allow for testing to see if a word
--  is a palindrome or not. Has a function to test is if a word is a
--  palindrome. Also implements functions/procedures to remove
--  non-letters and to convert a word to uppercase.
--********************************************************************

WITH Ada.Characters.Handling; USE Ada.Characters.Handling;

PACKAGE BODY WordPkg.Pals IS
   --*****************************************************************
   -- Tests to see if a word is a palindrome. Accepts a word type as
   -- a parameter. Loops through the word comparing the first half of
   -- the word to the inverse of the last half. Returns whether the
   -- word is a palindrome or not.
   --*****************************************************************
   FUNCTION IsPal (W : Word) RETURN Boolean IS
      Half: Natural;          --Half the length of the word.
      Valid: Boolean := TRUE; --Tells whether is a palindrome or not.
   BEGIN
      --Obtain half the length of the word.
      Half := W.Length/2;

      --Loop through the word, comparing the first half with the
      -- reverse of the second half, character by character. If
      -- a mismatch is found, set valid to flase.
      FOR I IN 0..Half LOOP
         --Compare the i'nth letter to the last-i'nth letter.
         IF((W.Letters(I+1) /= W.Letters(W.Length-I))) THEN
            Valid := FALSE;
         END IF;
      END LOOP;

      --Return whether the word is a palindrome or not.
      RETURN Valid;

   END IsPal;

   --*****************************************************************
   -- Accepts a word type as a parameter and then converts the word
   -- to uppercase. Returns the modified word.
   --*****************************************************************
   FUNCTION ToUpper (W : Word) RETURN Word IS
      NewW: Word := W; --Create a temporary word object.
   BEGIN
      --Loop through the word, converting each character to uppercase.
      FOR I IN 1..NewW.Length LOOP
         NewW.Letters(I) := To_Upper(NewW.Letters(I));
      END LOOP;

      --Return a word object with the word in uppercase.
      RETURN NewW;
   END ToUpper;

   --*****************************************************************
   -- Accepts a word type as a parameter and then removes non-letters
   -- from the word. Returns the modified word.
   --*****************************************************************
   FUNCTION RemoveNonLetter (W : Word) RETURN Word IS
      NewW: Word;                   --Create a temporary word object.
      TempLet: String(1..W.Length); --String to hold edited word.
      Count: Natural := 0;          --Number of actual letters.
   BEGIN
      --Loop through the word, checking if each character is a letter.
      FOR I IN 1..W.Length LOOP
         --If the character is a letter, insert it into temp string.
         IF(Is_Letter(W.Letters(I))) THEN
            Count := Count + 1;
            TempLet(Count) := w.Letters(I);
         END IF;
      END LOOP;

      --Remove any empty space at end of word.
      NewW := New_Word(TempLet(1..count));

      --Return a word object with the edited word.
      RETURN NewW;
   END RemoveNonLetter;

   --*****************************************************************
   -- Accepts a word type as a parameter and then converts the word
   -- to uppercase.
   --*****************************************************************
   PROCEDURE ToUpper (W : IN OUT Word) IS
   BEGIN
      --Loop through the word, converting each character to uppercase.
      FOR I IN 1..W.Length LOOP
         W.Letters(I) := To_Upper(W.Letters(I));
      END LOOP;
   END ToUpper;

   --*****************************************************************
   -- Accepts a word type as a parameter and then removes non-letters
   -- from the word.
   --*****************************************************************
   PROCEDURE RemoveNonLetter (W : IN OUT Word) IS
      TempLet: String(1..W.Length); --String to hold edited word.
      Count: Natural := 0;          --Number of actual letters.
   BEGIN
      --Loop through the word, checking if each character is a letter.
      FOR I IN 1..W.Length LOOP
         --If the character is a letter, insert it into temp string.
         IF(Is_Letter(W.Letters(I))) THEN
            Count := Count + 1;
            TempLet(Count) := W.Letters(I);
         END IF;
      END LOOP;

      --Put the edited word back into the word object.
      W := New_Word(TempLet(1..count));
   END RemoveNonLetter;

END WordPkg.Pals;