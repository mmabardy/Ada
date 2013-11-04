-- This Ada package body gives the implementation for the word abstract
-- data type.  A word is considered to be any consecutive sequence of
-- non-white-space characters.

with Ada.Text_IO; use Ada.Text_IO;
package WordPkg is

    type word is private;

    WordTooLong: Exception;

    -- Creates a new word corresponding to the given string.
    function New_Word(Item : String) return Word;

    -- Indicates the number of characters in a word.
    function Length (Item : Word) return Natural;

    -- Returns the maximum word size supported by this package.
    function Max_Word_Size return Positive;

    -- Word comparison functions.  The dictoinary lexiographic ordering
    -- is used to determine when one word is less than another.

    function "="  (X, Y : Word) return Boolean;
    function "<="  (X, Y : Word) return Boolean;
    function "<" (X, Y : Word) return Boolean;
    function ">=" (X, Y : Word) return Boolean;
    function ">"  (X, Y : Word) return Boolean;

    -- I/O routines

    -- Skip any white-space that may preceed the word in the input.
    -- If the word is too long to fit in the representation being
    -- used, then raise the WordTooLong exception after the characters
    -- of the word have been read (though not stored).
    procedure Get (File : File_Type; Item : out Word);
    procedure Get (Item : out Word);

    -- Write only those characters that make up the word.
    procedure Put (File : File_Type; Item : Word);
    procedure Put (Item : Word);

private

    MaxWordSize: Constant Natural := 80;
    type word is record
        Letters: String(1..MaxWordSize);
        Length: Natural := 0;
    end record;

end WordPkg;