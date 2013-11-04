-- This Ada package specification adds palindrome checking,
-- removal of non-letters, and transforming to upper and lower case
-- to the word package.

package WordPkg.Pals is
    function isPal(w: Word) return Boolean;

    function toUpper(w: Word) return Word;
    function removeNonLetter(w: Word) return Word;

    procedure toUpper(w: in out Word);
    procedure removeNonLetter(w: in out Word);
end WordPkg.Pals;