unit BCrypt.Controller;

(*
  Sample Usage
  ============

  //Hash a password using default cost (e.g. 11 ==> 2^11 ==> 2,048 rounds)
  hash := TBCrypt.HashPassword('hunter2');

  //Hash a password using custom cost factor
  hash := TBCrypt.HashPassword('hunter2', 14); //14 ==> 2^14 ==> 16,384 rounds

  //Check a password
  var
  passwordRehashNeeded: Boolean;

  TBCrypt.CheckPassword(szPassword, existingHash, {out}passwordRehashNeeded);


  Enhanced version
  ----------------

  Enhanced mode pre-hashes the password with SHA2-256. This gives three benfits:

  - overcomes the 72-byte limit on passwords; allowing them to be arbitrary long
  - avoids potential denial of service with really long passwords
  - bcrypt computation time will be independant of password length (i.e. no side-channel leak)

  // Hash password with SHA256 prehash:
  hash := TBCrytpt.EnhancedHashPassword('hunter2'); // $bcrypt-sha256$

  // Check enhanced password the same way as regular hashes
  isPasswordValid := TBCrypt.CheckPassword(szPassword, existingHash, {out}passwordRehashNeeded);


  Remarks
  =======

  Bcrypt is an algorithm designed for hashing passwords, and only passwords.

  i.e. It's not a generic, high-speed, generic hashing algorithm.
  It's not a password-based key derivation function
  It's computationally and memory expensive
  It's limited to passwords of 71 bytes.

  http://static.usenix.org/events/usenix99/provos/provos.pdf

  It uses the Blowfish encryption algorithm, but with an "expensive key setup" modification,
  contained in the function EksBlowfishSetup.


  Version History
  ===============

  Version 1.14     20190823
  - Added function to manually prehash a password using SHA-2_256
  - Added EnchancedHashPassword to prehash the password and output $bcrypt-sha256$ identifier
  - Improvement: unrolled main loop for performance improvement

  Version 1.13     20180729
  - UIntPtr isn't declared in Delphi 2010 (21.0). Maybe it first appeared in Delphi XE (22.0)?

  Version 1.12     20180419
  - Made compatible with Delphi 5
  - Published all self tests, but put slow ones behind the -SlowUnitTests command line parameter

  Version 1.11     20180120
  - Bugfix: The raw version of CheckPassword forgot to time the hash operation, and set PasswordRehashNeeded out parameter approriately

  Version 1.10     20161212
  - Bugfix: Don't zero out password byte array when it is empty - it's a range check error and unneeded

  Version 1.09     20161122
  - Added: In accordance with the recommendations of NIST SP 800-63B, we now apply KC normalization to the password.
  Choice was between NFKC and NFKD. SASLprep (rfc4013), like StringPrep (rfc3454) both specified NFKC.

  Version 1.08     20161029
  - We now burn the intermediate UTF8 form of the password.
  - BCrypt key has a maximum size of 72 bytes. We burn off any excess bytes after converting the string to utf8
  - Changed the handling of passwords longer than the 72 characters to match other implemntations.
  No longer do we forcibly add a terminating null, but instead simply chop the utf8 array at 72 bytes.

  Version 1.07     20160423
  - Changed: Fixed up compiler defines so that we work on Delphi 5, Delphi 7, and Delphi XE5 (the only versions of Delphi i use)
  - Added the fast SelfTests into their own DUnit test; the ones that are too slow are still kept in the public section
  - Added granular abilty to disable BCrypt unit tests

  Version 1.06     20151026
  - Added: CheckPassword functions now take "PasswordRehashNeeded" out parameter.
  The value will contain True if the password needs to be rehashed.
  For for example: if the BCrypt cost needs to be increased as the hash was calculated too quickly,
  or if the BCrypt standard has been updated (as OpenBSD updated their canonical output to 2b)
  - Updated: We now use OS CryptGenRandom for salt generation.
  If it fails, we fall back to a type 4 ("random") UUID.
  Salt doesn't have to be cryptographically strong, just different.
  - Fix: We now recognize version "2" and well as anything version "2"+[letter].
  OpenBSD canonical version now outputs "2c".
  We will continue to output "2b" for a while, at least hopefully until everyone's updated.
  Previous version would fail on anything besides "2a".
  In the case of a federated login, we can't have older software that only knows how to handle "2a" suddenly
  start failing when it encounters "2b".
  - Updated: Removed dependancy on Blowfish.pas. Copied relavent ECB function, state variable, and digits of PI

  Version 1.05     20150321
  - Performance improvement: Was so worried about using faster verison of Move in BlowfishEncryptECB and BlowfishDecryptECB,
  that i didn't stop to notice that i shouldn't even be using Move; but instead a 32-bit assignment
  - Fix: Fixed bug in EksBlowfishSetup. If you used a cost factor 31 (2,147,483,648), then the Integer loop
  control variable would overflow and the expensive key setup wouldn't run at all (zero iterations)
  - The original whitepaper mentions the maximum key length of 56 bytes.
  This was a misunderstanding based on the Blowfish maximum recommended key size of 448 bits.
  The algorithm can, and does, support up to 72 bytes (e.g. 71 ASCII characters + null terminator).
  Note: Variant 2b of bcrypt also *caps* the password length at 72 (to avoid integer wraparound on passwords longer than 2 billion characters O.o)

  Version 1.04     20150312
  - Performance improvement: ExpandKey: Hoisted loop variable, use xor to calculate SaltHalfIndex to avoid speculative execution jump, unrolled loop to two 32-bit XORs (16% faster)
  - Performance improvement (D5,D7): Now use pure pascal version of FastCode Move() (50% faster)

  Version 1.03     20150319
  - Fix: Defined away Modernizer (so people who are not me can use it)
  - Added: If no cost factor is specified when hashing a password,
  the cost factor is now a sliding factor, based on Moore's Law and when BCrypt was designed

  Version 1.02     20141215
  - Added support for XE2 string/UnicodeString/AnsiString
  - Update: Updated code to work in 64-bit environment

  Version 1.01     20130612
  - New: Added HashPassword overload that lets you specify your desired cost

  Version 1.0      20120504
  - Initial release by Ian Boyd, Public Domain


  Background
  ==========

  bcrypt was designed for OpenBSD, where hashes in the password file have a certain format.

  The convention used in BSD when generating password hash strings is to format it as:
  $version$salt$hash

  MD5 hash uses version "1":
  "$"+"1"+"$"+salt+hash

  bcrypt uses version "2a", but also encodes the cost

  "$"+"2a"+"$"+rounds+"$"+salt+hash

  e.g.
  $2a$10$Ro0CUfOqk6cXEKf3dyaM7OhSCvnwM9s4wIX9JeLapehKK5YdLxKcm
  $==$==$======================-------------------------------

  The benfit of this scheme is:
  - the number of rounds
  - the salt used

  This means that stored hashes are backwards and forwards compatible with changing the number of rounds


  BCrypt variants
  ===============

  $2$
  The original specification used the prefix $2$.
  This was in contrast to the other algorithm prefixes:
  $1$ - MD5
  $5$ - SHA-256
  $6$ - SHA-512

  $2a$
  The original specification did not define how to handle non-ASCII character, or how to handle a null terminator.
  The specification was revised to specify that when hashing strings:
  - the string must be UTF-8 encoded
  - the null terminator must be included

  $2x$, $2y$ June 2011
  A bug was discovered in crypt_blowfish, a PHP implementation of BCrypt.
  It was mis-handling characters with the 8th bit set.
  They suggested that system administrators update their existing password database, replacing $2a$ with $2x$,
  to indicate that those hashes are bad (and need to use the old broken algorithm).
  They also suggested the idea of having crypt_blowfish emit $2y$ for hashes generated by the fixed algorithm.
  Nobody else, including canonical OpenBSD, adopted the idea of 2x/2y. This version marker was was limited to crypt_blowfish.
  http://seclists.org/oss-sec/2011/q2/632

  $2b$ February 2014
  A bug was discovered in the OpenBSD implemenation of bcrypt.
  They were storing the length of their strings in an unsigned char.
  If a password was longer than 255 characters, it would overflow and wrap at 255.
  BCrypt was created for OpenBSD. When they have a bug in *their* library, they decided its ok to bump the version.
  This means that everyone else needs to follow suit if you want to remain current to "their" specification.
  http://undeadly.org/cgi?action=article&sid=20140224132743
  http://marc.info/?l=openbsd-misc&m=139320023202696
*)

interface

(*
  The problem is how to make "TBytes", "UIntPtr", and "UnicodeString" work in Delphi 5, Delphi 7, Delphi 2010, and XE2+

  | Item            | Delphi 5        | Delphi 7              | Delphi 2009            | Delphi 2010            | Delphi XE2             |
  |-----------------|-----------------|-----------------------|------------------------|------------------------|------------------------|
  | Product version | 5               | 7                     | 12                     | 14                     | 16                     |
  | Version         | VER130          | VER150                | VER200                 | VER210                 | VER230                 |
  | CompilerVersion | n/a             | 15.0                  | 20.0                   | 21.0                   | 23.0                   |
  | TBytes          | = array of Byte | = Types.TByteDynArray | = Types.TByteDynArray? | = Types.TByteDynArray? | = SysUtils.TBytes      |
  | UnicodeString   | = WideString    | = WideString          | = System.UnicodeString | = System.UnicodeString | = System.UnicodeString | Added in Delphi 2009
  | UIntPtr         | = Cardinal      | = Cardinal            | = Cardinal             | = Cardinal             | = System.UIntPtr       |

  And it wasn't until Delphi 6 (CompilerVersion >= 14.0) that conditional expressions (CONDITIONALEXPRESSIONS) were added.
*)
{$IFDEF CONDITIONALEXPRESSIONS}
{$IF CompilerVersion >= 22}
{$DEFINE COMPILER_15_UP} // Delphi XE
{$ENDIF}
{$IF CompilerVersion >= 15}
{$DEFINE COMPILER_7_UP} // Delphi 7
{$ENDIF}
{$ENDIF}

uses
   SysUtils, Windows, Math,
{$IFDEF COMPILER_7_UP}Types, {$ENDIF} // Types.pas didn't appear until ~Delphi 7.
   ComObj;

type
{$IFNDEF UNICODE}
   UnicodeString = WideString;
   // System.UnicodeString wasn't added until Delphi 2009
{$ENDIF}
{$IFDEF VER150} // Delphi 7
   TBytes = Types.TByteDynArray;
   // TByteDynArray wasn't added until around Delphi 7. Sometime later it moved to SysUtils.
{$ENDIF}
{$IFDEF VER130} // Delphi 5
   TBytes = array of Byte;
   // for old-fashioned Delphi 5, we have to do it ourselves
{$ENDIF}
{$IFNDEF COMPILER_15_UP}
   // Someone said that Delphi 2010 (Delphi 14) didn't have UIntPtr.
   // So maybe it was Delphi XE (Delphi 15)
   UIntPtr = Cardinal; // an unsigned, pointer sized, integer
{$ENDIF}

   TBlowfishData = record
      InitBlock: array [0 .. 7] of Byte; { initial IV }
      LastBlock: array [0 .. 7] of Byte; { current IV }
      SBox: array [0 .. 3, 0 .. 255] of DWORD;
      PBoxM: array [0 .. 17] of DWORD;
   end;

   TBCrypt = class(TObject)
   private
      class function TryParseHashString(const hashString: string;
        out version: string; out Cost: Integer; out Salt: TBytes;
        out IsEnhanced: Boolean): Boolean;
   protected
      class function EksBlowfishSetup(const Cost: Integer;
        const Salt, Key: array of Byte): TBlowfishData;
      class procedure ExpandKey(var state: TBlowfishData;
        const Salt, Key: array of Byte);
      class function CryptCore(const Cost: Integer; Key: array of Byte;
        Salt: array of Byte): TBytes;

      class function FormatPasswordHashForBsd(const version: string;
        const Cost: Integer; const Salt: array of Byte;
        const hash: array of Byte): string;
      class function FormatEnhancedPasswordHash(const version: string;
        const Cost: Integer; const Salt: array of Byte;
        const hash: array of Byte): string;

      class function BsdBase64Encode(const data: array of Byte;
        BytesToEncode: Integer): string;
      class function BsdBase64Decode(const s: string): TBytes;

      class function PasswordStringPrep(const Source: UnicodeString): TBytes;

      class function SelfTestA: Boolean; // known test vectors
      class function SelfTestB: Boolean; // BSD's base64 encoder/decoder
      class function SelfTestC: Boolean; // unicode strings in UTF8
      class function SelfTestD: Boolean; // different length passwords
      class function SelfTestE: Boolean; // salt rng
      class function SelfTestF: Boolean; // correctbatteryhorsestapler
      class function SelfTestG: Boolean;
      // check that we support up to 72 characters
      class function SelfTestH: Boolean;
      // check that we don't limit our passwords to 256 characters (as OpenBSD did)
      class function SelfTestI: Boolean;
      // check that we use unicode compatible composition (NFKC) on passwords
      class function SelfTestJ: Boolean;
      // check that composed and decomposed strings both validate to the same
      class function SelfTestK: Boolean; // SASLprep rules for passwords
      class function SelfTestL: Boolean;
      // Test prehashing a password (sha256 -> base64)

      class function GenRandomBytes(len: Integer; const data: Pointer): HRESULT;

      class function GetModernCost(SampleCost: Integer;
        SampleHashDurationMS: Real): Integer;
      class function GetModernCost_Benchmark: Integer;

      class function TimingSafeSameString(const Safe, User: string): Boolean;
      class function PasswordRehashNeededCore(const version: string;
        const Cost: Integer; SampleCost: Integer;
        SampleHashDurationMS: Real): Boolean;

      class function HashBytes256(data: TBytes): string;
      class function Base64Encode(const data: array of Byte): string;
   public
      // Hashes a password into the OpenBSD password-file format (non-standard base-64 encoding). Also validate that BSD style string
      class function HashPassword(const Password: UnicodeString)
        : string; overload;
      class function HashPassword(const Password: UnicodeString; Cost: Integer)
        : string; overload;
      class function CheckPassword(const Password: UnicodeString;
        const ExpectedHashString: string; out PasswordRehashNeeded: Boolean)
        : Boolean; overload;

      // Applies sha-256 preshashing to a password. The returned string is suitable to pass to HashPassword.
      class function Prehash256(const Password: UnicodeString): string;

      // Performs sha-256 pre-hashing on the password (to allow unlimited password lengths, and avoid DoS attacks). Emits '$bcrypt-sha256$' format.
      class function EnhancedHashPassword(const Password: UnicodeString)
        : string; overload;
      class function EnhancedHashPassword(const Password: UnicodeString;
        Cost: Integer): string; overload;

      // If you want to handle the cost, salt, and encoding yourself, you can do that.
      class function HashPassword(const Password: UnicodeString;
        const Salt: array of Byte; const Cost: Integer): TBytes; overload;
      class function CheckPassword(const Password: UnicodeString;
        const Salt, hash: array of Byte; const Cost: Integer;
        out PasswordRehashNeeded: Boolean): Boolean; overload;
      class function GenerateSalt: TBytes;

      // Evaluate the cost (or version) of a hash string, and figure out if it needs to be rehashed
      class function PasswordRehashNeeded(const hashString: string): Boolean;

      class function SelfTest: Boolean;
   end;

   EBCryptException = class(Exception);

implementation

{$IFDEF Strict}
{$DEFINE Sqm}
{$ENDIF}
{$IFDEF NoSqm}
{$UNDEF Sqm}
{$ENDIF}
{$IFDEF UnitTests}
{$DEFINE BCryptUnitTests}
{$ENDIF}
{$IFDEF NoBCryptUnitTests}
{$UNDEF BCryptUnitTests}
{$ENDIF}

uses
{$IFDEF Sqm}SqmApi, {$ENDIF}
{$IFDEF BCryptUnitTests}TestFramework, {$ENDIF}
   ActiveX;

const
   BCRYPT_COST = 11;
   // cost determintes the number of rounds. 11 = 2^11 rounds (2,048)
   {
     | Cost | Iterations        | E6300        | E5-2620     | i5-2500    | i7-2700K    |
     |                          |      2006-Q3 |     2012-Q1 |    2011-Q1 |     2011-Q4 |
     |                          |     1.86 GHz |       2 GHz |    3.3 GHz |     3.5 GHz |
     |------|-------------------|--------------|-------------|------------|-------------|
     |    8 |    256 iterations |     61.65 ms |     48.8 ms |    21.7 ms |     20.8 ms |  <-- minimum allowed by BCrypt
     |    9 |    512 iterations |    126.09 ms |     77.7 ms |    43.3 ms |     41.5 ms |
     |   10 |  1,024 iterations |    249.10 ms |    128.8 ms |    85.5 ms |     83.2 ms |
     |   11 |  2,048 iterations |    449.23 ms |    250.1 ms |   173.3 ms |    166.8 ms |  <-- current default (BCRYPT_COST=11)
     |   12 |  4,096 iterations |  1,007.05 ms |    498.8 ms |   345.6 ms |    333.4 ms |
     |   13 |  8,192 iterations |  1,995.48 ms |    999.1 ms |   694.3 ms |    667.9 ms |
     |   14 | 16,384 iterations |  4,006.78 ms |  1,997.6 ms | 1,390.5 ms |  1,336.5 ms |
     |   15 | 32,768 iterations |  8,027.05 ms |  3,999.9 ms | 2,781.4 ms |  2,670.5 ms |
     |   16 | 65,536 iterations | 15,982.14 ms |  8,008.2 ms | 5,564.9 ms |  5,342.8 ms |


     At the time of deployment in 1976, crypt could hash fewer than 4 passwords per second. (250 ms per password)
     In 1977, on a VAX-11/780, crypt (MD5) could be evaluated about 3.6 times per second.   (277 ms per password)
     If 277 ms per hash was our target, it would mean a range of 180 ms..360 ms.

     At the time of publication of BCrypt (1999) the default costs were:
     - Normal User: 6
     - the Superuser: 8

     "Of course, whatever cost people choose should be reevaluated from time to time."

     We want to target between 250-500ms per hash.
   }

   BCRYPT_SALT_LEN = 16;
   // bcrypt uses 128-bit (16-byte) salt (This isn't an adjustable parameter, just a name for a constant)
   BCRYPT_MaxKeyLen = 72; // 72 bytes ==> 71 ansi charcters + null terminator

   BsdBase64EncodeTable: array [0 .. 63] of Char =
   { 0: } './' +
   { 2: } 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
   { 28: } 'abcdefghijklmnopqrstuvwxyz' +
   { 54: } '0123456789';

   // the traditional base64 encode table:
   // 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
   // 'abcdefghijklmnopqrstuvwxyz' +
   // '0123456789+/';

   BsdBase64DecodeTable: array [#0 .. #127] of Integer = (
     { 0: } -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
     // ________________
     { 16: } -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
     // ________________
     { 32: } -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0, 1,
     // ______________./
     { 48: } 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, -1, -1, -1, -1, -1, -1,
     // 0123456789______
     { 64: } -1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
     // _ABCDEFGHIJKLMNO
     { 80: } 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, -1, -1, -1, -1, -1,
     // PQRSTUVWXYZ_____
     { 96: } -1, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42,
     // _abcdefghijklmno
     { 113: } 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, -1, -1, -1, -1, -1);
   // pqrstuvwxyz_____

   TestVectors: array [1 .. 20, 1 .. 3] of string =
     (('', '$2a$06$DCq7YPn5Rq63x1Lad4cll.',
     '$2a$06$DCq7YPn5Rq63x1Lad4cll.TV4S6ytwfsfvkgY8jIucDrjc8deX1s.'),
     ('', '$2a$08$HqWuK6/Ng6sg9gQzbLrgb.',
     '$2a$08$HqWuK6/Ng6sg9gQzbLrgb.Tl.ZHfXLhvt/SgVyWhQqgqcZ7ZuUtye'),
     ('', '$2a$10$k1wbIrmNyFAPwPVPSVa/ze',
     '$2a$10$k1wbIrmNyFAPwPVPSVa/zecw2BCEnBwVS2GbrmgzxFUOqW9dk4TCW'),
     ('', '$2a$12$k42ZFHFWqBp3vWli.nIn8u',
     '$2a$12$k42ZFHFWqBp3vWli.nIn8uYyIkbvYRvodzbfbK18SSsY.CsIQPlxO'),
     ('a', '$2a$06$m0CrhHm10qJ3lXRY.5zDGO',
     '$2a$06$m0CrhHm10qJ3lXRY.5zDGO3rS2KdeeWLuGmsfGlMfOxih58VYVfxe'),
     ('a', '$2a$08$cfcvVd2aQ8CMvoMpP2EBfe',
     '$2a$08$cfcvVd2aQ8CMvoMpP2EBfeodLEkkFJ9umNEfPD18.hUF62qqlC/V.'),
     ('a', '$2a$10$k87L/MF28Q673VKh8/cPi.',
     '$2a$10$k87L/MF28Q673VKh8/cPi.SUl7MU/rWuSiIDDFayrKk/1tBsSQu4u'),
     ('a', '$2a$12$8NJH3LsPrANStV6XtBakCe',
     '$2a$12$8NJH3LsPrANStV6XtBakCez0cKHXVxmvxIlcz785vxAIZrihHZpeS'),
     ('abc', '$2a$06$If6bvum7DFjUnE9p2uDeDu',
     '$2a$06$If6bvum7DFjUnE9p2uDeDu0YHzrHM6tf.iqN8.yx.jNN1ILEf7h0i'),
     ('abc', '$2a$08$Ro0CUfOqk6cXEKf3dyaM7O',
     '$2a$08$Ro0CUfOqk6cXEKf3dyaM7OhSCvnwM9s4wIX9JeLapehKK5YdLxKcm'),
     ('abc', '$2a$10$WvvTPHKwdBJ3uk0Z37EMR.',
     '$2a$10$WvvTPHKwdBJ3uk0Z37EMR.hLA2W6N9AEBhEgrAOljy2Ae5MtaSIUi'),
     ('abc', '$2a$12$EXRkfkdmXn2gzds2SSitu.',
     '$2a$12$EXRkfkdmXn2gzds2SSitu.MW9.gAVqa9eLS1//RYtYCmB1eLHg.9q'),
     ('abcdefghijklmnopqrstuvwxyz', '$2a$06$.rCVZVOThsIa97pEDOxvGu',
     '$2a$06$.rCVZVOThsIa97pEDOxvGuRRgzG64bvtJ0938xuqzv18d3ZpQhstC'),
     ('abcdefghijklmnopqrstuvwxyz', '$2a$08$aTsUwsyowQuzRrDqFflhge',
     '$2a$08$aTsUwsyowQuzRrDqFflhgekJ8d9/7Z3GV3UcgvzQW3J5zMyrTvlz.'),
     ('abcdefghijklmnopqrstuvwxyz', '$2a$10$fVH8e28OQRj9tqiDXs1e1u',
     '$2a$10$fVH8e28OQRj9tqiDXs1e1uxpsjN0c7II7YPKXua2NAKYvM6iQk7dq'),
     ('abcdefghijklmnopqrstuvwxyz', '$2a$12$D4G5f18o7aMMfwasBL7Gpu',
     '$2a$12$D4G5f18o7aMMfwasBL7GpuQWuP3pkrZrOAnqP.bmezbMng.QwJ/pG'),
     ('~!@#$%^&*()      ~!@#$%^&*()PNBFRD', '$2a$06$fPIsBO8qRqkjj273rfaOI.',
     '$2a$06$fPIsBO8qRqkjj273rfaOI.HtSV9jLDpTbZn782DC6/t7qT67P6FfO'),
     ('~!@#$%^&*()      ~!@#$%^&*()PNBFRD', '$2a$08$Eq2r4G/76Wv39MzSX262hu',
     '$2a$08$Eq2r4G/76Wv39MzSX262huzPz612MZiYHVUJe/OcOql2jo4.9UxTW'),
     ('~!@#$%^&*()      ~!@#$%^&*()PNBFRD', '$2a$10$LgfYWkbzEvQ4JakH7rOvHe',
     '$2a$10$LgfYWkbzEvQ4JakH7rOvHe0y8pHKF9OaFgwUZ2q7W2FFZmZzJYlfS'),
     ('~!@#$%^&*()      ~!@#$%^&*()PNBFRD', '$2a$12$WApznUOJfkEGSmYRfnkrPO',
     '$2a$12$WApznUOJfkEGSmYRfnkrPOr466oFDCaj4b6HY3EXGvfxm43seyhgC'));

   SInvalidHashString = 'Invalid base64 hash string';
   SBcryptCostRangeError = 'BCrypt cost factor must be between 4..31 (%d)';
   SKeyRangeError = 'Key must be between 1 and 72 bytes long (%d)';
   SSaltLengthError = 'Salt must be 16 bytes';
   SInvalidLength = 'Invalid length';

   {
     TODO: bcrypt with SHA256 pre-hashing

     passlib.hash.bcrypt_sha256 - BCrypt+SHA256¶
     https://passlib.readthedocs.io/en/stable/lib/passlib.hash.bcrypt_sha256.html

     BCrypt was developed to replace md5_crypt for BSD systems. It uses a modified version of the Blowfish stream cipher.
     It does, however, truncate passwords to 72 bytes, and some other minor quirks (see BCrypt Password Truncation for details).
     This class works around that issue by first running the password through SHA2-256.

     See also: https://blogs.dropbox.com/tech/2016/09/how-dropbox-securely-stores-your-passwords/
     who use sha-512 and truncate, rather than sha256.

     Format
     --------

     Bcrypt-SHA256 is compatible with the Modular Crypt Format, and uses $bcrypt-sha256$ as the identifying prefix for all
     it’s strings. An example hash (of password) is:

     $bcrypt-sha256$2a,12$LrmaIX5x4TRtAwEfwJZa1.$2ehnw6LvuIUTM0iz4iz9hTxv21B6KFO

     Bcrypt-SHA256 hashes have the format

     $bcrypt-sha256$[variant],[rounds]$[salt]$[checksum]

     where:
     - **variant**: is the BCrypt variant in use (usually, as in this case, `2a`).
     - **rounds**: is a cost parameter, encoded as decimal integer, which determines the number of iterations used
     via `iterations=2**rounds` (rounds is 12 in the example).
     - **salt** is a 22 character salt string, using the characters in the regexp range [./A-Za-z0-9]
     (LrmaIX5x4TRtAwEfwJZa1. in the example).
     - **checksum** is a 31 character checksum, using the same characters as the salt (2ehnw6LvuIUTM0iz4iz9hTxv21B6KFO in the example).


     Algorithm
     ---------

     The algorithm this hash uses is as follows:

     - first the password is encoded to UTF-8 if not already encoded.
     - then it’s run through SHA2-256 to generate a 32 byte digest.
     - this is encoded using base64, resulting in a 44-byte result (including the trailing padding =).
     For the example "password", the output from this stage would be "XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg=".
     - this base64 string is then passed on to the underlying bcrypt algorithm as the new password to be hashed.
   }

{$IFDEF BCryptUnitTests}

type
   TBCryptTests = class(TTestCase)
   public
      procedure SpeedTests;
      function GetCompilerOptions: string;
   public
      // These are just too darn slow (as they should be) for continuous testing
      procedure SelfTest;

   published
      procedure SelfTestA_KnownTestVectors; // known test vectors
      procedure SelfTestB_Base64EncoderDecoder; // BSD's base64 encoder/decoder
      procedure SelfTestC_UnicodeStrings; // unicode strings in UTF8
      procedure SelfTestD_VariableLengthPasswords; // different length passwords
      procedure SelfTestE_SaltRNG; // salt rng
      procedure SelfTestF_CorrectBattery; // correctbatteryhorsestapler
      procedure SelfTestG_PasswordLength;
      // check that we support up to 72 characters
      procedure SelfTestH_OpenBSDLengthBug;
      // check that we don't limit our passwords to 256 characters (as OpenBSD did)
      procedure SelfTestI_UnicodeCompatibleComposition;
      // check that we apply KC normalization (NIST SP 800-63B)
      procedure SelfTestJ_NormalizedPasswordsMatch; //
      procedure SelfTestK_SASLprep; //
      procedure SelfTestL_Prehash;

      procedure Test_ParseHashString;
      // How well we handle past, present, and future versioning strings

      procedure TestEnhancedHash;
      procedure TestParseEnhancedHash;

      procedure Benchmark;
      procedure Test_ManualSystem;
   end;
{$ENDIF}

const
   advapi32 = 'advapi32.dll';

function CryptAcquireContextW(out phProv: THandle; pszContainer: PWideChar;
  pszProvider: PWideChar; dwProvType: DWORD; dwFlags: DWORD): BOOL; stdcall;
  external advapi32;
function CryptReleaseContext(hProv: THandle; dwFlags: DWORD): BOOL; stdcall;
  external advapi32;
function CryptGenRandom(hProv: THandle; dwLen: DWORD; pbBuffer: Pointer): BOOL;
  stdcall; external advapi32;

procedure BurnString(var s: UnicodeString);
begin
   if Length(s) > 0 then
   begin
{$IFDEF UNICODE}
      {
        In Delphi 5 (and really anything before XE2), UnicodeString is an alias for WideString.
        WideString does not have, or does it need, an RTL UniqueString function.
      }
      UniqueString( { var } s);
      // We can't FillChar the string if it's shared, or its in the constant data page
{$ENDIF}
      FillChar(s[1], Length(s), 0);
      s := '';
   end;
end;

{ TBCrypt }

class function TBCrypt.HashPassword(const Password: UnicodeString): string;
var
   Cost: Integer;
begin
   {
     Generate a hash for the specified password using the default cost.

     Sample Usage:
     hash := TBCrypt.HashPassword('correct horse battery stample');


     Rather than using a fixed default cost, use a self-adjusting cost.
     We give ourselves two methods:

     - Moore's Law sliding constant
     - Benchmark

     The problem with using Moore's Law is that it's falling behind for single-core performance.
     Since 2004, single-core performance is only going up 21% per year, rather than the 26% of Moore's Law.

     26%/year ==> doubles every 18 months
     21%/year ==> doubles every 44 months

     So i could use a more practical variation of Moore's Law. Knowing that it is now doubling every 44 months,
     and that i want the target speed to be between 500-750ms, i could use the new value.

     The alternative is to run a quick benchmark. It only takes 1.8ms to do a cost=4 hash. Use it benchmark the computer.

     The 3rd alternative would be to run the hash as normal, and time it. If it takes less than 500ms to calculate, then
     do it again with a cost of BCRYPT_COST+1.
   }

   Cost := TBCrypt.GetModernCost_Benchmark;

   if Cost < BCRYPT_COST then
      Cost := BCRYPT_COST;

   Result := TBCrypt.HashPassword(Password, Cost);
end;

class function TBCrypt.HashPassword(const Password: UnicodeString;
  Cost: Integer): string;
var
   Salt: TBytes;
   hash: TBytes;
begin
   {
     Generate a hash for the supplied password using the specified cost.

     Sample usage:

     hash := TBCrypt.HashPassword('Correct battery Horse staple', 13); //Cost factor 13
   }

   Salt := GenerateSalt();

   hash := TBCrypt.HashPassword(Password, Salt, Cost);

   // 20151010  I don't want to emit 2b just yet. The previous bcrypt would fail on anything besides 2a.
   // This version handles any single letter suffix. But if we have cross system authentication, and an older system
   // tries to validate a 2b password it will fail.
   // Wait a year or so until everyone has the new bcrypt
   Result := FormatPasswordHashForBsd('2a', Cost, Salt, hash);
end;

class function TBCrypt.GenerateSalt: TBytes;
var
   type4Uuid: TGUID;
   Salt: TBytes;
begin
   // Salt is a 128-bit (16 byte) random value
   SetLength(Salt, BCRYPT_SALT_LEN);

   // 20150309  Use real random data. Fallback to random guid if it fails
   if Failed(Self.GenRandomBytes(BCRYPT_SALT_LEN, { out } @Salt[0])) then
   begin
      // Type 4 UUID (RFC 4122) is a handy source of (almost) 128-bits of random data (actually 120 bits)
      // But the security doesn't come from the salt being secret, it comes from the salt being different each time
      OleCheck(CoCreateGUID(type4Uuid));
      Move(type4Uuid.D1, Salt[0], BCRYPT_SALT_LEN); // 16 bytes
   end;

   Result := Salt;
end;

function CryptAcquireContext(out phProv: THandle; pszContainer: PWideChar;
  pszProvider: PWideChar; dwProvType: DWORD; dwFlags: DWORD): BOOL; stdcall;
  external advapi32 name 'CryptAcquireContextW';
function CryptCreateHash(hProv: THandle; Algid: LongWord; hKey: THandle;
  dwFlags: DWORD; out hHash: THandle): BOOL; stdcall; external advapi32;
function CryptHashData(hHash: THandle; pbData: PByte; dwDataLen: DWORD;
  dwFlags: DWORD): BOOL; stdcall; external advapi32;
function CryptGetHashParam(hHash: THandle; dwParam: DWORD; pbData: PByte;
  var dwDataLen: DWORD; dwFlags: DWORD): BOOL; stdcall; external advapi32;
function CryptDestroyHash(hHash: THandle): BOOL; stdcall; external advapi32;

class function TBCrypt.HashBytes256(data: TBytes): string;
var
   provider: THandle;
   hash: THandle;
   digestSize: Cardinal;
   digest: TBytes;
const
   PROV_RSA_AES = 24; // Provider type; from WinCrypt.h
   CRYPT_VERIFYCONTEXT = $F0000000;
   CALG_SHA_256 = $0000800C;
   HP_HASHVAL = $0002;
   HP_HASHSIZE = $0004;
begin
   SetLength(Result, 0);

   if not CryptAcquireContext( { out } provider, nil, nil, PROV_RSA_AES,
     CRYPT_VERIFYCONTEXT) then
      RaiseLastOSError;
   try
      if not CryptCreateHash(provider, CALG_SHA_256, 0, 0, { out } hash) then
         RaiseLastOSError;
      try
         // Hash the data
         if not CryptHashData(hash, PByte(data), Length(data), 0) then
            RaiseLastOSError;

         // Get the digest size. We know it's 32-bytes, but lets do what is correct.
         if not CryptGetHashParam(hash, HP_HASHVAL, nil, { var } digestSize, 0)
         then
            RaiseLastOSError;

         // Finalize the hash and get the digest
         SetLength(digest, Integer(digestSize));
         if not CryptGetHashParam(hash, HP_HASHVAL, @digest[0],
           { var } digestSize, 0) then
            RaiseLastOSError;

         Result := TBCrypt.Base64Encode(digest);
      finally
         CryptDestroyHash(hash);
      end;
   finally
      CryptReleaseContext(provider, 0);
   end;
end;

class function TBCrypt.HashPassword(const Password: UnicodeString;
  const Salt: array of Byte; const Cost: Integer): TBytes;
var
   Key: TBytes;
begin
   {
     The canonical BSD algorithm expects a null-terminated UTF8 key.
     If the key is longer than 72 bytes, they truncate the array of bytes to 72.

     Yes, this does mean that can can lose the null terminator, and we can chop a multi-byte utf8 code point into an invalid character.
   }

   // Pseudo-standard dictates that unicode strings are converted to UTF8 (rather than UTF16, UTF32, UTF16LE, ISO-8859-1, Windows-1252, etc)
   Key := TBCrypt.PasswordStringPrep(Password);
   try
      // Truncate if its longer than 72 bytes (BCRYPT_MaxKeyLen), and burn the excess
      if Length(Key) > BCRYPT_MaxKeyLen then
      begin
         ZeroMemory(@Key[BCRYPT_MaxKeyLen], Length(Key) - BCRYPT_MaxKeyLen);
         SetLength(Key, BCRYPT_MaxKeyLen);
      end;

      Result := TBCrypt.CryptCore(Cost, Key, Salt);
   finally
      if Length(Key) > 0 then
      begin
         ZeroMemory(@Key[0], Length(Key));
         SetLength(Key, 0);
      end;
   end;
end;

{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}

type
   TSBox = array [0 .. 255] of DWORD;
   PSBox = ^TSBox;

procedure BlowfishEncryptECB(const data: TBlowfishData; InData: PLongWord;
  OutData: PLongWord);
var
   xL, xR: LongWord;
   S0, S1, S2, S3: PSBox;
begin
   xL := PLongWord(InData)^;
   xR := PLongWord(UIntPtr(InData) + 4)^;

   xL := (xL shr 24) or ((xL shr 8) and $FF00) or ((xL shl 8) and $FF0000) or
     (xL shl 24);
   xR := (xR shr 24) or ((xR shr 8) and $FF00) or ((xR shl 8) and $FF0000) or
     (xR shl 24);

   xL := xL xor data.PBoxM[0];

   S0 := @data.SBox[0];
   S1 := @data.SBox[1];
   S2 := @data.SBox[2];
   S3 := @data.SBox[3];

   xR := xR xor (((S0[(xL shr 24)] + S1[Byte(xL shr 16)]) xor S2[Byte(xL shr 8)]
     ) + S3[Byte(xL)]) xor data.PBoxM[1];
   xL := xL xor (((S0[(xR shr 24)] + S1[Byte(xR shr 16)]) xor S2[Byte(xR shr 8)]
     ) + S3[Byte(xR)]) xor data.PBoxM[2];
   xR := xR xor (((S0[(xL shr 24)] + S1[Byte(xL shr 16)]) xor S2[Byte(xL shr 8)]
     ) + S3[Byte(xL)]) xor data.PBoxM[3];
   xL := xL xor (((S0[(xR shr 24)] + S1[Byte(xR shr 16)]) xor S2[Byte(xR shr 8)]
     ) + S3[Byte(xR)]) xor data.PBoxM[4];
   xR := xR xor (((S0[(xL shr 24)] + S1[Byte(xL shr 16)]) xor S2[Byte(xL shr 8)]
     ) + S3[Byte(xL)]) xor data.PBoxM[5];
   xL := xL xor (((S0[(xR shr 24)] + S1[Byte(xR shr 16)]) xor S2[Byte(xR shr 8)]
     ) + S3[Byte(xR)]) xor data.PBoxM[6];
   xR := xR xor (((S0[(xL shr 24)] + S1[Byte(xL shr 16)]) xor S2[Byte(xL shr 8)]
     ) + S3[Byte(xL)]) xor data.PBoxM[7];
   xL := xL xor (((S0[(xR shr 24)] + S1[Byte(xR shr 16)]) xor S2[Byte(xR shr 8)]
     ) + S3[Byte(xR)]) xor data.PBoxM[8];
   xR := xR xor (((S0[(xL shr 24)] + S1[Byte(xL shr 16)]) xor S2[Byte(xL shr 8)]
     ) + S3[Byte(xL)]) xor data.PBoxM[9];
   xL := xL xor (((S0[(xR shr 24)] + S1[Byte(xR shr 16)]) xor S2[Byte(xR shr 8)]
     ) + S3[Byte(xR)]) xor data.PBoxM[10];
   xR := xR xor (((S0[(xL shr 24)] + S1[Byte(xL shr 16)]) xor S2[Byte(xL shr 8)]
     ) + S3[Byte(xL)]) xor data.PBoxM[11];
   xL := xL xor (((S0[(xR shr 24)] + S1[Byte(xR shr 16)]) xor S2[Byte(xR shr 8)]
     ) + S3[Byte(xR)]) xor data.PBoxM[12];
   xR := xR xor (((S0[(xL shr 24)] + S1[Byte(xL shr 16)]) xor S2[Byte(xL shr 8)]
     ) + S3[Byte(xL)]) xor data.PBoxM[13];
   xL := xL xor (((S0[(xR shr 24)] + S1[Byte(xR shr 16)]) xor S2[Byte(xR shr 8)]
     ) + S3[Byte(xR)]) xor data.PBoxM[14];
   xR := xR xor (((S0[(xL shr 24)] + S1[Byte(xL shr 16)]) xor S2[Byte(xL shr 8)]
     ) + S3[Byte(xL)]) xor data.PBoxM[15];
   xL := xL xor (((S0[(xR shr 24)] + S1[Byte(xR shr 16)]) xor S2[Byte(xR shr 8)]
     ) + S3[Byte(xR)]) xor data.PBoxM[16];

   xR := xR xor data.PBoxM[17];

   // Copy xL,xR to output buffer
   xL := (xL shr 24) or ((xL shr 8) and $FF00) or ((xL shl 8) and $FF0000) or
     (xL shl 24);
   xR := (xR shr 24) or ((xR shr 8) and $FF00) or ((xR shl 8) and $FF0000) or
     (xR shl 24);

   // Got rid of the moves
   PLongWord(OutData)^ := xR;
   PLongWord(UIntPtr(OutData) + 4)^ := xL;
end;
{$RANGECHECKS ON}
{$OVERFLOWCHECKS ON}

class function TBCrypt.CryptCore(const Cost: Integer;
  Key, Salt: array of Byte): TBytes;
var
   state: TBlowfishData;
   i: Integer;
   plainText: array [0 .. 23] of Byte;
   cipherText: array [0 .. 23] of Byte;
{$IFDEF Sqm}t1: Int64; {$ENDIF}
const
   magicText: AnsiString = 'OrpheanBeholderScryDoubt';
   // the 24-byte data we will be encrypting 64 times
begin
{$IFDEF Sqm}
   t1 := Sqm.GetTimestamp;
{$ENDIF}
   try
      state := TBCrypt.EksBlowfishSetup(Cost, Salt, Key);

      // Conceptually we are encrypting "OrpheanBeholderScryDoubt" 64 times
      Move(magicText[1], plainText[0], 24);

      for i := 1 to 64 do
      begin
         // The painful thing is that the plaintext is 24 bytes long; this is three 8-byte blocks.
         // Which means we have to do the EBC encryption on 3 separate sections.
         BlowfishEncryptECB(state, Pointer(@plainText[0]),
           Pointer(@cipherText[0]));
         BlowfishEncryptECB(state, Pointer(@plainText[8]),
           Pointer(@cipherText[8]));
         BlowfishEncryptECB(state, Pointer(@plainText[16]),
           Pointer(@cipherText[16]));

         Move(cipherText[0], plainText[0], 24);
      end;

      // Copy final cipherText to Result
      SetLength(Result, 24);
      Move(cipherText[0], Result[0], 24);
   finally
      // Burn cipher state
      FillChar(state, SizeOf(state), 0);
      FillChar(plainText[0], SizeOf(plainText), 0);
      FillChar(cipherText[0], 24, 0);
   end;

{$IFDEF Sqm}
   Sqm.TimerStop('BCrypt/CryptCore', t1);
   Sqm.TimerStop('BCrypt/CryptCore/Cost' + IntToStr(Cost), t1);
{$ENDIF}
end;

class function TBCrypt.EksBlowfishSetup(const Cost: Integer;
  const Salt, Key: array of Byte): TBlowfishData;
var
   rounds: Cardinal; // rounds = 2^cost
   i: Cardinal;
   len: Integer;
const
   zero: array [0 .. 15] of Byte = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0);

   // SBLOCKS ARE THE HEX DIGITS OF PI.
   // The amount of hex digits can be increased if you want to experiment with more rounds and longer key lengths
   PBox: array [0 .. 17] of DWORD = ($243F6A88, $85A308D3, $13198A2E, $03707344,
     $A4093822, $299F31D0, $082EFA98, $EC4E6C89, $452821E6, $38D01377,
     $BE5466CF, $34E90C6C, $C0AC29B7, $C97C50DD, $3F84D5B5, $B5470917,
     $9216D5D9, $8979FB1B);

   SBox0: array [0 .. 255] of DWORD = ($D1310BA6, $98DFB5AC, $2FFD72DB,
     $D01ADFB7, $B8E1AFED, $6A267E96, $BA7C9045, $F12C7F99, $24A19947,
     $B3916CF7, $0801F2E2, $858EFC16, $636920D8, $71574E69, $A458FEA3,
     $F4933D7E, $0D95748F, $728EB658, $718BCD58, $82154AEE, $7B54A41D,
     $C25A59B5, $9C30D539, $2AF26013, $C5D1B023, $286085F0, $CA417918,
     $B8DB38EF, $8E79DCB0, $603A180E, $6C9E0E8B, $B01E8A3E, $D71577C1,
     $BD314B27, $78AF2FDA, $55605C60, $E65525F3, $AA55AB94, $57489862,
     $63E81440, $55CA396A, $2AAB10B6, $B4CC5C34, $1141E8CE, $A15486AF,
     $7C72E993, $B3EE1411, $636FBC2A, $2BA9C55D, $741831F6, $CE5C3E16,
     $9B87931E, $AFD6BA33, $6C24CF5C, $7A325381, $28958677, $3B8F4898,
     $6B4BB9AF, $C4BFE81B, $66282193, $61D809CC, $FB21A991, $487CAC60,
     $5DEC8032, $EF845D5D, $E98575B1, $DC262302, $EB651B88, $23893E81,
     $D396ACC5, $0F6D6FF3, $83F44239, $2E0B4482, $A4842004, $69C8F04A,
     $9E1F9B5E, $21C66842, $F6E96C9A, $670C9C61, $ABD388F0, $6A51A0D2,
     $D8542F68, $960FA728, $AB5133A3, $6EEF0B6C, $137A3BE4, $BA3BF050,
     $7EFB2A98, $A1F1651D, $39AF0176, $66CA593E, $82430E88, $8CEE8619,
     $456F9FB4, $7D84A5C3, $3B8B5EBE, $E06F75D8, $85C12073, $401A449F,
     $56C16AA6, $4ED3AA62, $363F7706, $1BFEDF72, $429B023D, $37D0D724,
     $D00A1248, $DB0FEAD3, $49F1C09B, $075372C9, $80991B7B, $25D479D8,
     $F6E8DEF7, $E3FE501A, $B6794C3B, $976CE0BD, $04C006BA, $C1A94FB6,
     $409F60C4, $5E5C9EC2, $196A2463, $68FB6FAF, $3E6C53B5, $1339B2EB,
     $3B52EC6F, $6DFC511F, $9B30952C, $CC814544, $AF5EBD09, $BEE3D004,
     $DE334AFD, $660F2807, $192E4BB3, $C0CBA857, $45C8740F, $D20B5F39,
     $B9D3FBDB, $5579C0BD, $1A60320A, $D6A100C6, $402C7279, $679F25FE,
     $FB1FA3CC, $8EA5E9F8, $DB3222F8, $3C7516DF, $FD616B15, $2F501EC8,
     $AD0552AB, $323DB5FA, $FD238760, $53317B48, $3E00DF82, $9E5C57BB,
     $CA6F8CA0, $1A87562E, $DF1769DB, $D542A8F6, $287EFFC3, $AC6732C6,
     $8C4F5573, $695B27B0, $BBCA58C8, $E1FFA35D, $B8F011A0, $10FA3D98,
     $FD2183B8, $4AFCB56C, $2DD1D35B, $9A53E479, $B6F84565, $D28E49BC,
     $4BFB9790, $E1DDF2DA, $A4CB7E33, $62FB1341, $CEE4C6E8, $EF20CADA,
     $36774C01, $D07E9EFE, $2BF11FB4, $95DBDA4D, $AE909198, $EAAD8E71,
     $6B93D5A0, $D08ED1D0, $AFC725E0, $8E3C5B2F, $8E7594B7, $8FF6E2FB,
     $F2122B64, $8888B812, $900DF01C, $4FAD5EA0, $688FC31C, $D1CFF191,
     $B3A8C1AD, $2F2F2218, $BE0E1777, $EA752DFE, $8B021FA1, $E5A0CC0F,
     $B56F74E8, $18ACF3D6, $CE89E299, $B4A84FE0, $FD13E0B7, $7CC43B81,
     $D2ADA8D9, $165FA266, $80957705, $93CC7314, $211A1477, $E6AD2065,
     $77B5FA86, $C75442F5, $FB9D35CF, $EBCDAF0C, $7B3E89A0, $D6411BD3,
     $AE1E7E49, $00250E2D, $2071B35E, $226800BB, $57B8E0AF, $2464369B,
     $F009B91E, $5563911D, $59DFA6AA, $78C14389, $D95A537F, $207D5BA2,
     $02E5B9C5, $83260376, $6295CFA9, $11C81968, $4E734A41, $B3472DCA,
     $7B14A94A, $1B510052, $9A532915, $D60F573F, $BC9BC6E4, $2B60A476,
     $81E67400, $08BA6FB5, $571BE91F, $F296EC6B, $2A0DD915, $B6636521,
     $E7B9F9B6, $FF34052E, $C5855664, $53B02D5D, $A99F8FA1, $08BA4799,
     $6E85076A);
   SBox1: array [0 .. 255] of DWORD = ($4B7A70E9, $B5B32944, $DB75092E,
     $C4192623, $AD6EA6B0, $49A7DF7D, $9CEE60B8, $8FEDB266, $ECAA8C71,
     $699A17FF, $5664526C, $C2B19EE1, $193602A5, $75094C29, $A0591340,
     $E4183A3E, $3F54989A, $5B429D65, $6B8FE4D6, $99F73FD6, $A1D29C07,
     $EFE830F5, $4D2D38E6, $F0255DC1, $4CDD2086, $8470EB26, $6382E9C6,
     $021ECC5E, $09686B3F, $3EBAEFC9, $3C971814, $6B6A70A1, $687F3584,
     $52A0E286, $B79C5305, $AA500737, $3E07841C, $7FDEAE5C, $8E7D44EC,
     $5716F2B8, $B03ADA37, $F0500C0D, $F01C1F04, $0200B3FF, $AE0CF51A,
     $3CB574B2, $25837A58, $DC0921BD, $D19113F9, $7CA92FF6, $94324773,
     $22F54701, $3AE5E581, $37C2DADC, $C8B57634, $9AF3DDA7, $A9446146,
     $0FD0030E, $ECC8C73E, $A4751E41, $E238CD99, $3BEA0E2F, $3280BBA1,
     $183EB331, $4E548B38, $4F6DB908, $6F420D03, $F60A04BF, $2CB81290,
     $24977C79, $5679B072, $BCAF89AF, $DE9A771F, $D9930810, $B38BAE12,
     $DCCF3F2E, $5512721F, $2E6B7124, $501ADDE6, $9F84CD87, $7A584718,
     $7408DA17, $BC9F9ABC, $E94B7D8C, $EC7AEC3A, $DB851DFA, $63094366,
     $C464C3D2, $EF1C1847, $3215D908, $DD433B37, $24C2BA16, $12A14D43,
     $2A65C451, $50940002, $133AE4DD, $71DFF89E, $10314E55, $81AC77D6,
     $5F11199B, $043556F1, $D7A3C76B, $3C11183B, $5924A509, $F28FE6ED,
     $97F1FBFA, $9EBABF2C, $1E153C6E, $86E34570, $EAE96FB1, $860E5E0A,
     $5A3E2AB3, $771FE71C, $4E3D06FA, $2965DCB9, $99E71D0F, $803E89D6,
     $5266C825, $2E4CC978, $9C10B36A, $C6150EBA, $94E2EA78, $A5FC3C53,
     $1E0A2DF4, $F2F74EA7, $361D2B3D, $1939260F, $19C27960, $5223A708,
     $F71312B6, $EBADFE6E, $EAC31F66, $E3BC4595, $A67BC883, $B17F37D1,
     $018CFF28, $C332DDEF, $BE6C5AA5, $65582185, $68AB9802, $EECEA50F,
     $DB2F953B, $2AEF7DAD, $5B6E2F84, $1521B628, $29076170, $ECDD4775,
     $619F1510, $13CCA830, $EB61BD96, $0334FE1E, $AA0363CF, $B5735C90,
     $4C70A239, $D59E9E0B, $CBAADE14, $EECC86BC, $60622CA7, $9CAB5CAB,
     $B2F3846E, $648B1EAF, $19BDF0CA, $A02369B9, $655ABB50, $40685A32,
     $3C2AB4B3, $319EE9D5, $C021B8F7, $9B540B19, $875FA099, $95F7997E,
     $623D7DA8, $F837889A, $97E32D77, $11ED935F, $16681281, $0E358829,
     $C7E61FD6, $96DEDFA1, $7858BA99, $57F584A5, $1B227263, $9B83C3FF,
     $1AC24696, $CDB30AEB, $532E3054, $8FD948E4, $6DBC3128, $58EBF2EF,
     $34C6FFEA, $FE28ED61, $EE7C3C73, $5D4A14D9, $E864B7E3, $42105D14,
     $203E13E0, $45EEE2B6, $A3AAABEA, $DB6C4F15, $FACB4FD0, $C742F442,
     $EF6ABBB5, $654F3B1D, $41CD2105, $D81E799E, $86854DC7, $E44B476A,
     $3D816250, $CF62A1F2, $5B8D2646, $FC8883A0, $C1C7B6A3, $7F1524C3,
     $69CB7492, $47848A0B, $5692B285, $095BBF00, $AD19489D, $1462B174,
     $23820E00, $58428D2A, $0C55F5EA, $1DADF43E, $233F7061, $3372F092,
     $8D937E41, $D65FECF1, $6C223BDB, $7CDE3759, $CBEE7460, $4085F2A7,
     $CE77326E, $A6078084, $19F8509E, $E8EFD855, $61D99735, $A969A7AA,
     $C50C06C2, $5A04ABFC, $800BCADC, $9E447A2E, $C3453484, $FDD56705,
     $0E1E9EC9, $DB73DBD3, $105588CD, $675FDA79, $E3674340, $C5C43465,
     $713E38D8, $3D28F89E, $F16DFF20, $153E21E7, $8FB03D4A, $E6E39F2B,
     $DB83ADF7);
   SBox2: array [0 .. 255] of DWORD = ($E93D5A68, $948140F7, $F64C261C,
     $94692934, $411520F7, $7602D4F7, $BCF46B2E, $D4A20068, $D4082471,
     $3320F46A, $43B7D4B7, $500061AF, $1E39F62E, $97244546, $14214F74,
     $BF8B8840, $4D95FC1D, $96B591AF, $70F4DDD3, $66A02F45, $BFBC09EC,
     $03BD9785, $7FAC6DD0, $31CB8504, $96EB27B3, $55FD3941, $DA2547E6,
     $ABCA0A9A, $28507825, $530429F4, $0A2C86DA, $E9B66DFB, $68DC1462,
     $D7486900, $680EC0A4, $27A18DEE, $4F3FFEA2, $E887AD8C, $B58CE006,
     $7AF4D6B6, $AACE1E7C, $D3375FEC, $CE78A399, $406B2A42, $20FE9E35,
     $D9F385B9, $EE39D7AB, $3B124E8B, $1DC9FAF7, $4B6D1856, $26A36631,
     $EAE397B2, $3A6EFA74, $DD5B4332, $6841E7F7, $CA7820FB, $FB0AF54E,
     $D8FEB397, $454056AC, $BA489527, $55533A3A, $20838D87, $FE6BA9B7,
     $D096954B, $55A867BC, $A1159A58, $CCA92963, $99E1DB33, $A62A4A56,
     $3F3125F9, $5EF47E1C, $9029317C, $FDF8E802, $04272F70, $80BB155C,
     $05282CE3, $95C11548, $E4C66D22, $48C1133F, $C70F86DC, $07F9C9EE,
     $41041F0F, $404779A4, $5D886E17, $325F51EB, $D59BC0D1, $F2BCC18F,
     $41113564, $257B7834, $602A9C60, $DFF8E8A3, $1F636C1B, $0E12B4C2,
     $02E1329E, $AF664FD1, $CAD18115, $6B2395E0, $333E92E1, $3B240B62,
     $EEBEB922, $85B2A20E, $E6BA0D99, $DE720C8C, $2DA2F728, $D0127845,
     $95B794FD, $647D0862, $E7CCF5F0, $5449A36F, $877D48FA, $C39DFD27,
     $F33E8D1E, $0A476341, $992EFF74, $3A6F6EAB, $F4F8FD37, $A812DC60,
     $A1EBDDF8, $991BE14C, $DB6E6B0D, $C67B5510, $6D672C37, $2765D43B,
     $DCD0E804, $F1290DC7, $CC00FFA3, $B5390F92, $690FED0B, $667B9FFB,
     $CEDB7D9C, $A091CF0B, $D9155EA3, $BB132F88, $515BAD24, $7B9479BF,
     $763BD6EB, $37392EB3, $CC115979, $8026E297, $F42E312D, $6842ADA7,
     $C66A2B3B, $12754CCC, $782EF11C, $6A124237, $B79251E7, $06A1BBE6,
     $4BFB6350, $1A6B1018, $11CAEDFA, $3D25BDD8, $E2E1C3C9, $44421659,
     $0A121386, $D90CEC6E, $D5ABEA2A, $64AF674E, $DA86A85F, $BEBFE988,
     $64E4C3FE, $9DBC8057, $F0F7C086, $60787BF8, $6003604D, $D1FD8346,
     $F6381FB0, $7745AE04, $D736FCCC, $83426B33, $F01EAB71, $B0804187,
     $3C005E5F, $77A057BE, $BDE8AE24, $55464299, $BF582E61, $4E58F48F,
     $F2DDFDA2, $F474EF38, $8789BDC2, $5366F9C3, $C8B38E74, $B475F255,
     $46FCD9B9, $7AEB2661, $8B1DDF84, $846A0E79, $915F95E2, $466E598E,
     $20B45770, $8CD55591, $C902DE4C, $B90BACE1, $BB8205D0, $11A86248,
     $7574A99E, $B77F19B6, $E0A9DC09, $662D09A1, $C4324633, $E85A1F02,
     $09F0BE8C, $4A99A025, $1D6EFE10, $1AB93D1D, $0BA5A4DF, $A186F20F,
     $2868F169, $DCB7DA83, $573906FE, $A1E2CE9B, $4FCD7F52, $50115E01,
     $A70683FA, $A002B5C4, $0DE6D027, $9AF88C27, $773F8641, $C3604C06,
     $61A806B5, $F0177A28, $C0F586E0, $006058AA, $30DC7D62, $11E69ED7,
     $2338EA63, $53C2DD94, $C2C21634, $BBCBEE56, $90BCB6DE, $EBFC7DA1,
     $CE591D76, $6F05E409, $4B7C0188, $39720A3D, $7C927C24, $86E3725F,
     $724D9DB9, $1AC15BB4, $D39EB8FC, $ED545578, $08FCA5B5, $D83D7CD3,
     $4DAD0FC4, $1E50EF5E, $B161E6F8, $A28514D9, $6C51133C, $6FD5C7E7,
     $56E14EC4, $362ABFCE, $DDC6C837, $D79A3234, $92638212, $670EFA8E,
     $406000E0);
   SBox3: array [0 .. 255] of DWORD = ($3A39CE37, $D3FAF5CF, $ABC27737,
     $5AC52D1B, $5CB0679E, $4FA33742, $D3822740, $99BC9BBE, $D5118E9D,
     $BF0F7315, $D62D1C7E, $C700C47B, $B78C1B6B, $21A19045, $B26EB1BE,
     $6A366EB4, $5748AB2F, $BC946E79, $C6A376D2, $6549C2C8, $530FF8EE,
     $468DDE7D, $D5730A1D, $4CD04DC6, $2939BBDB, $A9BA4650, $AC9526E8,
     $BE5EE304, $A1FAD5F0, $6A2D519A, $63EF8CE2, $9A86EE22, $C089C2B8,
     $43242EF6, $A51E03AA, $9CF2D0A4, $83C061BA, $9BE96A4D, $8FE51550,
     $BA645BD6, $2826A2F9, $A73A3AE1, $4BA99586, $EF5562E9, $C72FEFD3,
     $F752F7DA, $3F046F69, $77FA0A59, $80E4A915, $87B08601, $9B09E6AD,
     $3B3EE593, $E990FD5A, $9E34D797, $2CF0B7D9, $022B8B51, $96D5AC3A,
     $017DA67D, $D1CF3ED6, $7C7D2D28, $1F9F25CF, $ADF2B89B, $5AD6B472,
     $5A88F54C, $E029AC71, $E019A5E6, $47B0ACFD, $ED93FA9B, $E8D3C48D,
     $283B57CC, $F8D56629, $79132E28, $785F0191, $ED756055, $F7960E44,
     $E3D35E8C, $15056DD4, $88F46DBA, $03A16125, $0564F0BD, $C3EB9E15,
     $3C9057A2, $97271AEC, $A93A072A, $1B3F6D9B, $1E6321F5, $F59C66FB,
     $26DCF319, $7533D928, $B155FDF5, $03563482, $8ABA3CBB, $28517711,
     $C20AD9F8, $ABCC5167, $CCAD925F, $4DE81751, $3830DC8E, $379D5862,
     $9320F991, $EA7A90C2, $FB3E7BCE, $5121CE64, $774FBE32, $A8B6E37E,
     $C3293D46, $48DE5369, $6413E680, $A2AE0810, $DD6DB224, $69852DFD,
     $09072166, $B39A460A, $6445C0DD, $586CDECF, $1C20C8AE, $5BBEF7DD,
     $1B588D40, $CCD2017F, $6BB4E3BB, $DDA26A7E, $3A59FF45, $3E350A44,
     $BCB4CDD5, $72EACEA8, $FA6484BB, $8D6612AE, $BF3C6F47, $D29BE463,
     $542F5D9E, $AEC2771B, $F64E6370, $740E0D8D, $E75B1357, $F8721671,
     $AF537D5D, $4040CB08, $4EB4E2CC, $34D2466A, $0115AF84, $E1B00428,
     $95983A1D, $06B89FB4, $CE6EA048, $6F3F3B82, $3520AB82, $011A1D4B,
     $277227F8, $611560B1, $E7933FDC, $BB3A792B, $344525BD, $A08839E1,
     $51CE794B, $2F32C9B7, $A01FBAC9, $E01CC87E, $BCC7D1F6, $CF0111C3,
     $A1E8AAC7, $1A908749, $D44FBD9A, $D0DADECB, $D50ADA38, $0339C32A,
     $C6913667, $8DF9317C, $E0B12B4F, $F79E59B7, $43F5BB3A, $F2D519FF,
     $27D9459C, $BF97222C, $15E6FC2A, $0F91FC71, $9B941525, $FAE59361,
     $CEB69CEB, $C2A86459, $12BAA8D1, $B6C1075E, $E3056A0C, $10D25065,
     $CB03A442, $E0EC6E0E, $1698DB3B, $4C98A0BE, $3278E964, $9F1F9532,
     $E0D392DF, $D3A0342B, $8971F21E, $1B0A7441, $4BA3348C, $C5BE7120,
     $C37632D8, $DF359F8D, $9B992F2E, $E60B6F47, $0FE3F11D, $E54CDA54,
     $1EDAD891, $CE6279CF, $CD3E7E6F, $1618B166, $FD2C1D05, $848FD2C5,
     $F6FB2299, $F523F357, $A6327623, $93A83531, $56CCCD02, $ACF08162,
     $5A75EBB5, $6E163697, $88D273CC, $DE966292, $81B949D0, $4C50901B,
     $71C65614, $E6C6C7BD, $327A140A, $45E1D006, $C3F27B9A, $C9AA53FD,
     $62A80F00, $BB25BFE2, $35BDD2F6, $71126905, $B2040222, $B6CBCF7C,
     $CD769C2B, $53113EC0, $1640E3D3, $38ABBD60, $2547ADF0, $BA38209C,
     $F746CE76, $77AFA1C5, $20756060, $85CBFE4E, $8AE88DD8, $7AAAF9B0,
     $4CF9AA7E, $1948C25C, $02FB8A8C, $01C36AE4, $D6EBE1F9, $90D4F869,
     $A65CDEA0, $3F09252D, $C208E69F, $B74E6132, $CE77E25B, $578FDFE3,
     $3AC372E6);
begin
   // Expensive key setup
   if (Cost < 4) or (Cost > 31) then
      raise EBCryptException.CreateFmt(SBcryptCostRangeError, [Cost]);
   // 'BCrypt cost factor must be between 4..31 (%d)'

   len := Length(Key);
   if (len > BCRYPT_MaxKeyLen) then // maximum of 72 bytes
      raise EBCryptException.CreateFmt(SKeyRangeError, [len]);
   // 'Key must be between 1 and 72 bytes long (%d)'

   if Length(Salt) <> BCRYPT_SALT_LEN then
      raise EBCryptException.Create(SSaltLengthError);
   // 'Salt must be 16 bytes'

   // Copy S and P boxes into local state
   Move(SBox0, Result.SBox[0], SizeOf(SBox0));
   Move(SBox1, Result.SBox[1], SizeOf(SBox1));
   Move(SBox2, Result.SBox[2], SizeOf(SBox2));
   Move(SBox3, Result.SBox[3], SizeOf(SBox3));
   Move(PBox, Result.PBoxM, SizeOf(PBox));

   Self.ExpandKey( { var } Result, Salt, Key);

   // rounds = 2^cost
   rounds := 1 shl Cost;

   for i := 1 to rounds do
   begin
      Self.ExpandKey( { var } Result, zero, Key);
      Self.ExpandKey( { var } Result, zero, Salt);
   end;

   // Result := what it is
end;

class function TBCrypt.EnhancedHashPassword(const Password: UnicodeString;
  Cost: Integer): string;
var
   Salt: TBytes;
   prehashedPassword: UnicodeString;
   hash: TBytes;
begin
   {
     Generate a hash for the supplied password using the specified cost.

     Sample usage:

     hash := TBCrypt.EnhancedHashPassword('Correct battery Horse staple', 13); //Cost factor 13

     Returned hash format:

     $bcrypt-sha256$2a,12$LrmaIX5x4TRtAwEfwJZa1.$2ehnw6LvuIUTM0iz4iz9hTxv21B6KFO
     \_____________/\/ \/ \____________________/ \_____________________________/
     Identifier    |  |        Salt                       Hash
     Version  Cost factor

   }
   Salt := GenerateSalt();
   prehashedPassword := TBCrypt.Prehash256(Password);
   try
      hash := TBCrypt.HashPassword(prehashedPassword, Salt, Cost);
   finally
      BurnString( { var } prehashedPassword);
   end;

   Result := FormatEnhancedPasswordHash('2b', Cost, Salt, hash);
end;

class function TBCrypt.EnhancedHashPassword(const Password
  : UnicodeString): string;
var
   Cost: Integer;
begin
   {
     Generate a hash for the specified password using the default cost.

     Sample Usage:
     hash := TBCrypt.HashPassword('correct horse battery stample');

     Returned hash format:

     $bcrypt-sha256$2a,12$LrmaIX5x4TRtAwEfwJZa1.$2ehnw6LvuIUTM0iz4iz9hTxv21B6KFO
   }

   Cost := TBCrypt.GetModernCost_Benchmark;

   if Cost < BCRYPT_COST then
      Cost := BCRYPT_COST;

   Result := TBCrypt.EnhancedHashPassword(Password, Cost);
end;

type
   TBlowfishBlock = packed record
      Lo: LongWord;
      Hi: LongWord;
   end;

   PBlowfishBlock = ^TBlowfishBlock;

class procedure TBCrypt.ExpandKey(var state: TBlowfishData;
  const Salt, Key: array of Byte);
var
   i, j, k: Integer;
   A: DWORD;
   KeyB: PByteArray;
   block: array [0 .. 7] of Byte;
   // block: TBlowfishBlock;
   len: Integer;
   // saltHalf: Integer;
   saltHalfIndex: Integer;
begin
   {
     This is the function that is called 8000 times.
   }
   // TODO: burn all stack variables

   // ExpandKey phase of the Expensive key setup
   len := Length(Key);
   if (len > BCRYPT_MaxKeyLen) then
      raise EBCryptException.CreateFmt(SKeyRangeError, [len]);
   // 'Key must be between 1 and 72 bytes long (%d)'

   {
     XOR all the subkeys in the P-array with the encryption key
     The first 32 bits of the key are XORed with P1, the next 32 bits with P2, and so on.
     The key is viewed as being cyclic; when the process reaches the end of the key,
     it starts reusing bits from the beginning to XOR with subkeys.
   }
   if len > 0 then
   begin
      KeyB := PByteArray(@Key[0]);
      k := 0;
      for i := 0 to 17 do
      begin
         A := KeyB[(k + 3) mod len];
         A := A + (KeyB[(k + 2) mod len] shl 8);
         A := A + (KeyB[(k + 1) mod len] shl 16);
         A := A + (KeyB[k] shl 24);
         state.PBoxM[i] := state.PBoxM[i] xor A;
         k := (k + 4) mod len;
      end;
   end;

   // Blowfish-encrypt the first 64 bits of the salt argument using the current state of the key schedule.
   BlowfishEncryptECB(state, PLongWord(@Salt[0]), PLongWord(@block));

   // The resulting ciphertext replaces subkeys P1 and P2.
   state.PBoxM[0] := block[3] + (block[2] shl 8) + (block[1] shl 16) +
     (block[0] shl 24);
   state.PBoxM[1] := block[7] + (block[6] shl 8) + (block[5] shl 16) +
     (block[4] shl 24);

{$RANGECHECKS OFF}
   saltHalfIndex := 8;
   for i := 1 to 8 do
   begin
      // That same ciphertext is also XORed with the second 64-bits of salt

      // Delphi compiler is not worth its salt; it doesn't do hoisting ("Any compiler worth its salt will hoist" - Eric Brumer C++ compiler team)
      // Salt is 0..15 (0..7 is first block, 8..15 is second block)
      PLongWord(@block[0])^ := PLongWord(@block[0])
        ^ xor PLongWord(@Salt[saltHalfIndex])^;
      PLongWord(@block[4])^ := PLongWord(@block[4])
        ^ xor PLongWord(@Salt[saltHalfIndex + 4])^;
      // block.Lo := block.Lo xor PLongWord(@salt[saltHalfIndex+0])^;
      // block.Hi := block.Hi xor PLongWord(@salt[saltHalfIndex+4])^;

      // saltHalf := saltHalf xor 1;
      saltHalfIndex := saltHalfIndex xor 8;
      // toggle between 0 -> 8 -> 0 -> 8 -> etc

      // and the result encrypted with the new state of the key schedule
      BlowfishEncryptECB(state, @block, @block);

      // The output of the second encryption replaces subkeys P3 and P4. (P[2] and P[3])
      state.PBoxM[i * 2 + 0] := LongWord(block[3]) or (block[2] shl 8) or
        (block[1] shl 16) or (block[0] shl 24);
      state.PBoxM[i * 2 + 1] := LongWord(block[7]) or (block[6] shl 8) or
        (block[5] shl 16) or (block[4] shl 24);
   end;

   // When ExpandKey finishes replacing entries in the P-Array, it continues on replacing S-box entries two at a time.
   for j := 0 to 3 do
   begin
      i := 0;
      while (i < 256) do
      begin
         // That same ciphertext is also XORed with the second 64-bits of salt
         // Delphi compiler is not worth its salt; it doesn't do hoisting ("Any compiler worth its salt will hoist" - Eric Brumer C++ compiler team)
         // Salt is 0..15 (0..7 is first block, 8..15 is second block)
         PLongWord(@block[0])^ := PLongWord(@block[0])
           ^ xor PLongWord(@Salt[saltHalfIndex])^;
         PLongWord(@block[4])^ := PLongWord(@block[4])
           ^ xor PLongWord(@Salt[saltHalfIndex + 4])^;

         // saltHalf := saltHalf xor 1;
         saltHalfIndex := saltHalfIndex xor 8;

         // and the result encrypted with the new state of the key schedule
         BlowfishEncryptECB(state, @block, @block);

         // The output of the second encryption replaces subkeys S1 and P2. (S[0] and S[1])
         state.SBox[j, i + 0] := LongWord(block[3]) or (block[2] shl 8) or
           (block[1] shl 16) or (block[0] shl 24);
         state.SBox[j, i + 1] := LongWord(block[7]) or (block[6] shl 8) or
           (block[5] shl 16) or (block[4] shl 24);

         Inc(i, 2);
      end;
   end;
{$RANGECHECKS ON}
end;

class function TBCrypt.CheckPassword(const Password: UnicodeString;
  const Salt, hash: array of Byte; const Cost: Integer;
  out PasswordRehashNeeded: Boolean): Boolean;
var
   candidateHash: TBytes;
   len: Integer;
   freq, t1, t2: Int64;
begin
   Result := False;
   PasswordRehashNeeded := False;

   if not QueryPerformanceFrequency( { var } freq) then
      freq := -1; // avoid a division by zero

   // Measure how long it takes to run the hash. If it's too quick, it's time to increase the cost
   if not QueryPerformanceCounter(t1) then
      t1 := 0;

   candidateHash := TBCrypt.HashPassword(Password, Salt, Cost);

   if not QueryPerformanceCounter(t2) then
      t2 := 0;

   len := Length(hash);
   if Length(candidateHash) <> len then
      Exit;

   Result := CompareMem(@candidateHash[0], @hash[0], len);

   // Based on how long it took to hash the password, see if a rehash is needed to increase the cost
   PasswordRehashNeeded := TBCrypt.PasswordRehashNeededCore(version, Cost, Cost,
     (t2 - t1) / freq * 1000);
end;

{$IFNDEF UNICODE}

function CharInSet(C: Char; const CharSet: TSysCharSet): Boolean;
begin
   Result := C in CharSet;
end;
{$ENDIF}

function StrToken(var s: string; Separator: Char): string;
var
   i: Integer;
begin
   i := Pos(Separator, s);

   if i <> 0 then
   begin
      Result := Copy(s, 1, i - 1);
      Delete(s, 1, i);
   end
   else
   begin
      Result := s;
      s := '';
   end;
end;

class function TBCrypt.TryParseHashString(const hashString: string;
  out version: string; out Cost: Integer; out Salt: TBytes;
  out IsEnhanced: Boolean): Boolean;
var
   writeableHash: string;
   s: string;
   n: Integer; // current index

   function GetNextToken(var index: Integer): string;
   var
      maxLen: Integer;
      startIndex, copyLen: Integer;
   begin
      Result := '';
      maxLen := Length(hashString);
      if (index > maxLen) then
         Exit;

      // Make sure we start on a "$" token divider
      if hashString[index] <> '$' then
         Exit;

      // Move past the "$" into the token value
      Inc(index);

      startIndex := index;
      copyLen := 0;

      while (index <= maxLen) and (hashString[index] <> '$') do
      begin
         Inc(index);
         Inc(copyLen);
      end;
      if copyLen > 0 then
         Result := Copy(hashString, startIndex, copyLen);
   end;

begin
   Result := False;
   version := '';
   Cost := 0;
   SetLength(Salt, 0);
   IsEnhanced := False;

   {
     Pick apart our specially formatted hash string

     $2a$nn$[22 character salt, b64 encoded][32 character hash, b64 encoded]

     We also need to accept version 2, the original version

     $2$nn$[22 character salt, b64 encoded][32 character hash, b64 encoded]
   }
   if Length(hashString) < 27 then // "$2$4$" + 22 = 27
      Exit;

   // Check for the "$bcrypt-sha256" prefix.
   if SameText(Copy(hashString, 1, 15), '$bcrypt-sha256$') then
   begin
      {
        $bcrypt-sha256$[Version],[Cost]$[salt]$[hash]

        $bcrypt-sha256$2b,12$LrmaIX5x4TRtAwEfwJZa1.$2ehnw6LvuIUTM0iz4iz9hTxv21B6KFO
      }
      writeableHash := Copy(hashString, 16, Length(hashString));
      version := StrToken(writeableHash, ','); // "2b"
      if (not SameText(version, '2')) and (not SameText(version, '2a')) and
        (not SameText(version, '2y')) and (not SameText(version, '2b')) then
         Exit;

      // Get cost token
      s := StrToken(writeableHash, '$');
      Cost := StrToIntDef(s, -1);
      if Cost < 4 then // 4 is the minimum allowed - ever
         Exit;

      s := StrToken(writeableHash, '$');
      if Length(s) <> 22 then
         Exit;
      try
         Salt := BsdBase64Decode(s);
         // salt is always 16 bytes (16 bytes * 4/3 --> 22 base64 characters)
      except
         on EBCryptException do // E.g. invalid base64 string
            Exit;
      end;

      IsEnhanced := True;
      Result := True;
      Exit;
   end;

   // Get version token
   n := 1;
   version := GetNextToken( { var } n);
   if version = '' then
      Exit;
   if version[1] = '2' then
   begin
      if Length(version) > 1 then
      begin
         if Length(version) > 2 then
         // we only comprehend "2c", where c is a character
            Exit;
         if not CharInSet(version[2], ['A' .. 'Z', 'a' .. 'z']) then
            Exit;
      end;

      // Get cost token
      s := GetNextToken( { var } n);
      Cost := StrToIntDef(s, -1);
      if Cost <= 0 then
         Exit;

      // Get remaining 22 character salt
      // s := Copy(GetNextToken({var}n), 1, 22);
      s := GetNextToken( { var } n);
      s := Copy(s, 1, 22);
      if Length(s) < 22 then
         Exit;
      try
         Salt := BsdBase64Decode(s);
         // salt is always 16 bytes (16 bytes * 4/3 --> 22 base64 characters)
      except
         on EBCryptException do // E.g. invalid base64 string
            Exit;
      end;

      Result := True;
      Exit;
   end;
end;

class function TBCrypt.CheckPassword(const Password: UnicodeString;
  const ExpectedHashString: string; out PasswordRehashNeeded: Boolean): Boolean;
var
   version: string;
   Cost: Integer;
   Salt: TBytes;
   IsEnhanced: Boolean;
   hash: TBytes;
   actualHashString: string;
   prehashedPassword: string;
   freq, t1, t2: Int64;
begin
   PasswordRehashNeeded := False;
   // indicates if your hash needs upgrading in version or cost

   if not QueryPerformanceFrequency( { var } freq) then
      freq := -1; // avoid a division by zero

   if not TryParseHashString(ExpectedHashString, { out } version, { out } Cost,
     { out } Salt, { out } IsEnhanced) then
      raise Exception.Create(SInvalidHashString);

   // Measure how long it takes to run the hash. If it's too quick, it's time to increase the cost
   if not QueryPerformanceCounter(t1) then
      t1 := 0;

   if IsEnhanced then
   begin
      prehashedPassword := TBCrypt.Prehash256(Password);
      hash := TBCrypt.HashPassword(prehashedPassword, Salt, Cost);
      BurnString(prehashedPassword);
   end
   else
      hash := TBCrypt.HashPassword(Password, Salt, Cost);

   if not QueryPerformanceCounter(t2) then
      t2 := 0;

   if IsEnhanced then
      actualHashString := FormatEnhancedPasswordHash(version, Cost, Salt, hash)
   else
      actualHashString := FormatPasswordHashForBsd(version, Cost, Salt, hash);

   // Result := (actualHashString = expectedHashString);
   Result := TBCrypt.TimingSafeSameString(actualHashString, ExpectedHashString);

   // Based on how long it took to hash the password, see if a rehash is needed to increase the cost
   PasswordRehashNeeded := TBCrypt.PasswordRehashNeededCore(version, Cost, Cost,
     (t2 - t1) / freq * 1000);
end;

class function TBCrypt.BsdBase64Encode(const data: array of Byte;
  BytesToEncode: Integer): string;

   function EncodePacket(b1, b2, b3: Byte; len: Integer): string;
   begin
      Result := '';

      Result := Result + BsdBase64EncodeTable[b1 shr 2];
      Result := Result + BsdBase64EncodeTable[((b1 and $03) shl 4) or
        (b2 shr 4)];
      if len < 2 then
         Exit;

      Result := Result + BsdBase64EncodeTable[((b2 and $0F) shl 2) or
        (b3 shr 6)];
      if len < 3 then
         Exit;

      Result := Result + BsdBase64EncodeTable[b3 and $3F];
   end;

var
   i: Integer;
   len: Integer;
   b1, b2: Integer;
begin
   Result := '';

   len := BytesToEncode;
   if len = 0 then
      Exit;

   if len > Length(data) then
      raise EBCryptException.Create(SInvalidLength);

   // encode whole 3-byte chunks  TV4S 6ytw fsfv kgY8 jIuc Drjc 8deX 1s.
   i := Low(data);
   while len >= 3 do
   begin
      Result := Result + EncodePacket(data[i], data[i + 1], data[i + 2], 3);
      Inc(i, 3);
      Dec(len, 3);
   end;

   if len = 0 then
      Exit;

   // encode partial final chunk
   Assert(len < 3);
   if len >= 1 then
      b1 := data[i]
   else
      b1 := 0;
   if len >= 2 then
      b2 := data[i + 1]
   else
      b2 := 0;
   Result := Result + EncodePacket(b1, b2, 0, len);
end;

class function TBCrypt.SelfTest: Boolean;
begin
   Result := True;

   Result := Result and SelfTestA; // known test vectors
   Result := Result and SelfTestB; // the base64 encoder/decoder
   Result := Result and SelfTestC; // unicode strings
   Result := Result and SelfTestD; // different length passwords
   Result := Result and SelfTestE; // salt RNG
   Result := Result and SelfTestF; // example of correct horse battery staple
   Result := Result and SelfTestG;
   // 72 byte key length (71characters + 1 null = 72)
   Result := Result and SelfTestH;
   // check out handling of strings longer than 255 characters
   Result := Result and SelfTestI;
   // check that we use unicode compatible composition (NFKC) on passwords
   Result := Result and SelfTestJ;
   // check that composed and decomposed strings both validate to the same
   Result := Result and SelfTestK; // SASLprep rules for passwords

   Result := Result and SelfTestL;
   // Test prehashing a password (sha256 -> base64)
end;

class function TBCrypt.FormatEnhancedPasswordHash(const version: string;
  const Cost: Integer; const Salt, hash: array of Byte): string;
var
   saltString: string;
   hashString: string;
begin
   {
     $bcrypt-sha256$[version],[cost]$[salt]$[hash]

     [version]: 2b
     [cost]:    12
     [salt]:    22 characters base64
     [hash]:    31 characters hash
   }
   saltString := BsdBase64Encode(Salt, Length(Salt));
   hashString := BsdBase64Encode(hash, Length(hash) - 1);
   // Yes, everything except the last byte.
   // OpenBSD, in the pseudo-base64 implementation, doesn't include the last byte of the hash
   // Nobody knows why, but that's what all existing tests do - so it's what i do

   Result := Format('$bcrypt-sha256$%s,%d$%s$%s', [version, Cost, saltString,
     hashString]);
end;

class function TBCrypt.FormatPasswordHashForBsd(const version: string;
  const Cost: Integer; const Salt, hash: array of Byte): string;
var
   saltString: string;
   hashString: string;
begin
   {
     $[version]$[cost]$[salt][hash]

     [version]: 2, 2a, 2b
     [cost]:    12
     [salt]:    22 characters base64
     [hash]:    31 characters hash
   }
   saltString := BsdBase64Encode(Salt, Length(Salt));
   hashString := BsdBase64Encode(hash, Length(hash) - 1);
   // Yes, everything except the last byte.
   // OpenBSD, in the pseudo-base64 implementation, doesn't include the last byte of the hash
   // Nobody knows why, but that's what all existing tests do - so it's what i do

   Result := Format('$%s$%.2d$%s%s', [version, Cost, saltString, hashString]);
end;

class function TBCrypt.Base64Encode(const data: array of Byte): string;

const
   // b64: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
   Base64EncodeTable: array [0 .. 63]
     of Char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

   function EncodePacket(b1, b2, b3: Byte; len: Integer): string;
   begin
      {
        b1       b2       b3
        |        |        |
        /------\ /------\ /------\
        11111111 22222222 33333333
        \____/\_____/\_____/\____/
        |      |      |     |
        c1     c2     c3    c4
      }
      Result := '====';

      Result[1] := Base64EncodeTable[b1 shr 2];
      Result[2] := Base64EncodeTable[((b1 and $03) shl 4) or (b2 shr 4)];
      if len < 2 then
         Exit;

      Result[3] := Base64EncodeTable[((b2 and $0F) shl 2) or (b3 shr 6)];
      if len < 3 then
         Exit;

      Result[4] := Base64EncodeTable[b3 and $3F];
   end;

var
   i: Integer;
   len: Integer;
   b1, b2: Integer;
begin
   Result := '';

   len := Length(data);
   if len = 0 then
      Exit;

   // encode whole 3-byte chunks  TV4S 6ytw fsfv kgY8 jIuc Drjc 8deX 1s.
   i := Low(data);
   while len >= 3 do
   begin
      Result := Result + EncodePacket(data[i], data[i + 1], data[i + 2], 3);
      Inc(i, 3);
      Dec(len, 3);
   end;

   if len = 0 then
      Exit;

   // encode partial final chunk
   Assert(len < 3);
   if len >= 1 then
      b1 := data[i]
   else
      b1 := 0;
   if len >= 2 then
      b2 := data[i + 1]
   else
      b2 := 0;
   Result := Result + EncodePacket(b1, b2, 0, len);
end;

class function TBCrypt.BsdBase64Decode(const s: string): TBytes;

   function Char64(character: Char): Integer;
   begin
      if (Ord(character) > Length(BsdBase64DecodeTable)) then
      begin
         Result := -1;
         Exit;
      end;

      Result := BsdBase64DecodeTable[character];
   end;

   procedure Append(value: Byte);
   var
      i: Integer;
   begin
      i := Length(Result);
      SetLength(Result, i + 1);
      Result[i] := value;
   end;

var
   i: Integer;
   len: Integer;
   c1, c2, c3, c4: Integer;
begin
   SetLength(Result, 0);

   len := Length(s);
   i := 1;
   while i <= len do
   begin
      // We'll need to have at least 2 character to form one byte.
      // Anything less is invalid
      if (i + 1) > len then
      begin
         raise EBCryptException.Create(SInvalidHashString);
         // 'Invalid base64 hash string'
         // Break;
      end;

      c1 := Char64(s[i]);
      Inc(i);
      c2 := Char64(s[i]);
      Inc(i);

      if (c1 = -1) or (c2 = -1) then
      begin
         raise EBCryptException.Create(SInvalidHashString);
         // 'Invalid base64 hash string'
         // Break;
      end;

      // Now we have at least one byte in c1|c2
      // c1 = ..111111
      // c2 = ..112222
      Append(((c1 and $3F) shl 2) or (c2 shr 4));

      // If there's a 3rd character, then we can use c2|c3 to form the second byte
      if (i > len) then
         Break;
      c3 := Char64(s[i]);
      Inc(i);

      if (c3 = -1) then
      begin
         raise EBCryptException.Create(SInvalidHashString);
         // 'Invalid base64 hash string'
         // Break;
      end;

      // Now we have the next byte in c2|c3
      // c2 = ..112222
      // c3 = ..222233
      Append(((c2 and $0F) shl 4) or (c3 shr 2));

      // If there's a 4th caracter, then we can use c3|c4 to form the third byte
      if i > len then
         Break;
      c4 := Char64(s[i]);
      Inc(i);

      if (c4 = -1) then
      begin
         raise EBCryptException.Create(SInvalidHashString);
         // 'Invalid base64 hash string'
         // Break;
      end;

      // Now we have the next byte in c3|c4
      // c3 = ..222233
      // c4 = ..333333
      Append(((c3 and $03) shl 6) or c4);
   end;
end;


// Requires Vista or newer. Similar functionality existed in Windows 2000 under FoldString
// function NormalizeString(NormForm: Cardinal; SrcString: PWideChar; SrcLength: Cardinal; DstString: PWideChar; DstLength: Cardinal): Integer; stdcall; external 'Normaliz.dll';

class function TBCrypt.PasswordStringPrep(const Source: UnicodeString): TBytes;
var
   normalizedLength: Integer;
   normalized: UnicodeString;
   strLen: Integer;
   dw: DWORD;
const
   CodePage = CP_UTF8;
   SLenError =
     '[PasswordStringPrep] Could not get length of destination string. Error %d (%s)';
   SConvertStringError =
     '[PasswordStringPrep] Could not convert utf16 to utf8 string. Error %d (%s)';
begin
   if Length(Source) = 0 then
   begin
      SetLength(Result, 0);
      Exit;
   end;

   {
     20161122
     NIST Special Publication 800-63-3B (Digital Authentication Guideline - Authentication and Lifecycle Management)
     https://pages.nist.gov/800-63-3/sp800-63b.html

     Reminds us to normalize the string (using either NFKC or NFKD).
     - K (Compatibility normalization): decomposes ligatures into base compatibilty characters
     - C (Composition):                 adds character+diacritic into single code point (if possible)
     - D (Decomposition):               separates an accented character into the letter and the diacritic

     SASLprep (rfc4013), like StringPrep (rfc3454) both specified NFKC:

     Before: Noe¨l
     After:  Noël

     Spaces
     ======

     RFC7613 - Preparation, Enforcement, and Comparison of Internationalized Strings Representing Usernames and Passwords,
     like RFC4013 that it obsoletes, reminds us to normalize all the differnet unicode space characters into the
     standard single U+0020 SPACE:

     2.  Additional Mapping Rule: Any instances of non-ASCII space MUST be mapped to ASCII space (U+0020);
     a non-ASCII space is any Unicode code point having a Unicode general category of "Zs"
     (with the  exception of U+0020).

     U+0020	SPACE
     U+00A0	NO-BREAK SPACE
     U+1680	OGHAM SPACE MARK
     U+2000	EN QUAD
     U+2001	EM QUAD
     U+2002	EN SPACE
     U+2003	EM SPACE
     U+2004	THREE-PER-EM SPACE
     U+2005	FOUR-PER-EM SPACE
     U+2006	SIX-PER-EM SPACE
     U+2007	FIGURE SPACE
     U+2008	PUNCTUATION SPACE
     U+2009	THIN SPACE
     U+200A	HAIR SPACE
     U+202F	NARROW NO-BREAK SPACE
     U+205F	MEDIUM MATHEMATICAL SPACE
     U+3000	IDEOGRAPHIC SPACE

     This is handled by NFC.
   }

   // We use concrete variable for length, because i've seen it return asking for 64 bytes for a 6 byte string
   // normalizedLength := NormalizeString(5, PWideChar(Source), Length(Source), nil, 0);
   normalizedLength := FoldStringW(MAP_FOLDCZONE, PWideChar(Source),
     Length(Source), nil, 0);
   if normalizedLength = 0 then
   begin
      dw := GetLastError;
      raise EConvertError.CreateFmt(SLenError, [dw, SysErrorMessage(dw)]);
   end;

   // Allocate memory for destination string
   SetLength(normalized, normalizedLength);

   // Now do it for real
   try
      // normalizedLength := NormalizeString(5, PWideChar(Source), Length(Source), PWideChar(normalized), Length(normalized));
      normalizedLength := FoldStringW(MAP_FOLDCZONE, PWideChar(Source),
        Length(Source), PWideChar(normalized), Length(normalized));
      if normalizedLength = 0 then
      begin
         dw := GetLastError;
         raise EConvertError.CreateFmt(SLenError, [dw, SysErrorMessage(dw)]);
      end;

      {
        Now perform the conversion of UTF-16 to UTF-8
      }
      // Determine real size of destination string, in bytes
      strLen := WideCharToMultiByte(CodePage, 0, PWideChar(normalized),
        normalizedLength, // Source
        nil, 0, // Destination
        nil, nil);
      if strLen = 0 then
      begin
         dw := GetLastError;
         raise EConvertError.CreateFmt(SLenError, [dw, SysErrorMessage(dw)]);
      end;

      // Allocate memory for destination string
      SetLength(Result, strLen + 1); // +1 for the null terminator

      // Convert source UTF-16 string (WideString) to the destination using the code-page
      strLen := WideCharToMultiByte(CodePage, 0, PWideChar(normalized),
        normalizedLength, // Source
        PAnsiChar(Result), strLen, // Destination
        nil, nil);
      if strLen = 0 then
      begin
         dw := GetLastError;
         raise EConvertError.CreateFmt(SConvertStringError,
           [dw, SysErrorMessage(dw)]);
      end;

      // Set the null terminator
      Result[strLen] := 0;
   finally
      // Burn the intermediate normalized form
      BurnString(normalized);
   end;
end;

class function TBCrypt.Prehash256(const Password: UnicodeString): string;
var
   Key: TBytes;

   procedure BurnArray(var AArray: TBytes);
   begin
      if Length(AArray) > 0 then
      begin
         ZeroMemory(@AArray[0], Length(AArray));
         SetLength(AArray, 0);
      end;
   end;

begin
   {
     - Prep the password from a string into bytes
     - Convert the bytes into a SHA-256 digest
     - Base64 encode the digest
   }
   Key := TBCrypt.PasswordStringPrep(Password);
   try
      Result := TBCrypt.HashBytes256(Key);
   finally
      BurnArray(Key);
   end;
end;

class function TBCrypt.SelfTestB: Boolean;
var
   i: Integer;
   Salt: string;
   encoded: string;
   data: TBytes;
   recoded: string;
const
   SSelfTestFailed = 'BSDBase64 encoder self-test failed';
begin
   for i := Low(TestVectors) to High(TestVectors) do
   begin
      Salt := TestVectors[i, 2];

      encoded := Copy(Salt, 8, 22); // salt is always 22 characters

      data := TBCrypt.BsdBase64Decode(encoded);

      recoded := TBCrypt.BsdBase64Encode(data, Length(data));
      if (recoded <> encoded) then
         raise Exception.Create(SSelfTestFailed);
   end;

   Result := True;
end;

class function TBCrypt.SelfTestA: Boolean;
var
   i: Integer;

   procedure t(const Password: UnicodeString; const HashSalt: string;
     const ExpectedHashString: string);
   var
      version: string;
      Cost: Integer;
      Salt: TBytes;
      IsEnhanced: Boolean;
      hash: TBytes;
      actualHashString: string;
   begin
      // Extract "$2a$06$If6bvum7DFjUnE9p2uDeDu" rounds and base64 salt from the HashSalt
      if not TBCrypt.TryParseHashString(HashSalt, { out } version, { out } Cost,
        { out } Salt, { out } IsEnhanced) then
         raise Exception.Create('bcrypt self-test failed: invalid versionsalt "'
           + HashSalt + '"');

      hash := TBCrypt.HashPassword(Password, Salt, Cost);
      actualHashString := TBCrypt.FormatPasswordHashForBsd(version, Cost,
        Salt, hash);

      if actualHashString <> ExpectedHashString then
         raise Exception.CreateFmt
           ('bcrypt self-test failed. Password: "%s". Actual hash "%s". Expected hash: "%s"',
           [Password, actualHashString, ExpectedHashString]);
   end;

begin
   for i := Low(TestVectors) to High(TestVectors) do
   begin
      t(TestVectors[i, 1], TestVectors[i, 2], TestVectors[i, 3]);
   end;

   Result := True;
end;

class function TBCrypt.SelfTestC: Boolean;
var
   s: UnicodeString;
   hash: string;
   rehashNeeded: Boolean;
const
   n: UnicodeString = ''; // n=nothing.
   // Work around bug in Delphi compiler when building widestrings
   // http://stackoverflow.com/a/7031942/12597
begin
   {
     We test that the it doesn't choke on international characters
     This was a bug in a version of bcrypt somewhere, that we do not intend to duplicate
   }
   s := n + #$03C0 + #$03C0 + #$03C0 + #$03C0 + #$03C0 + #$03C0 + #$03C0 +
     #$03C0; // U+03C0: Greek Small Letter Pi
   hash := TBCrypt.HashPassword(s);
   if not TBCrypt.CheckPassword(s, hash, { out } rehashNeeded) then
      raise Exception.Create('Failed to validate unicode string "' + s + '"');

   s := n + #$03C0 + #$03C0 + #$03C0 + #$03C0 + #$03C0 + #$03C0 + #$03C0 +
     #$03C0; // U+03C0: Greek Small Letter Pi
   hash := TBCrypt.HashPassword(s);
   if not TBCrypt.CheckPassword(s, hash, { out } rehashNeeded) then
      raise Exception.Create('Failed to validate unicode string "' + s + '"');

   Result := True;
end;

class function TBCrypt.GenRandomBytes(len: Integer;
  const data: Pointer): HRESULT;
var
   hProv: THandle;
const
   PROV_RSA_FULL = 1;
   CRYPT_VERIFYCONTEXT = DWORD($F0000000);
   CRYPT_SILENT = $00000040;
begin
   if not CryptAcquireContextW(hProv, nil, nil, PROV_RSA_FULL,
     CRYPT_VERIFYCONTEXT or CRYPT_SILENT) then
   begin
      Result := HResultFromWin32(GetLastError);
      Exit;
   end;
   try
      if not CryptGenRandom(hProv, len, data) then
      begin
         Result := HResultFromWin32(GetLastError);
         Exit;
      end;
   finally
      CryptReleaseContext(hProv, 0);
   end;

   Result := S_OK;
end;

class function TBCrypt.GetModernCost(SampleCost: Integer;
  SampleHashDurationMS: Real): Integer;
begin
   {
     Given a Cost factor, and how long it took to compute the hash, figure out the cost needed to get a hashing duration
     between 250ms - 500ms. Maybe 200-400. It probably needs some discussion.

     This function is used not only as part of the benchmark to decide on a cost for new passwords, but we
     also use it to measure how long it took to check an existing password, and decide if it was too quick
     and the password hash needs to be upgraded.

     What speed to use?
     ==================

     At the time of deployment in 1976, crypt could hash fewer than 4 passwords per second. (250 ms per password)
     In 1977, on a VAX-11/780, crypt (MD5) could be evaluated about 3.6 times per second.   (277 ms per password)

     At the time of publication of BCrypt (1999) the default costs were:
     - Normal User: 6
     - the Superuser: 8

     "Of course, whatever cost people choose should be reevaluated from time to time."

     Speed tests from the paper from 1999 for Cost 5
     - OpenBSD 2.3, P5 133 MHz:     156.2 ms  (6.4 crypts/sec)
     - x86 assembler, P5 133 MHz:     4.4 ms  (22.5 crypts/sec)
     - Alpha 21164A 600 MHz:          1.6 ms  (62.5 crypts/sec)

     That means that these speeds would for Cost 6 be:
     - OpenBSD 2.3, P5 133 MHz:     312.5 ms
     - x86 assembler, P5 133 MHz:     8.9 ms
     - Alpha 21164A 600 MHz:          3.2 ms

     For cost 8 (superuser) these would be:
     - OpenBSD 2.3, P5 133 MHz:   1,250.0 ms
     - x86 assembler, P5 133 MHz:    35.6 ms
     - Alpha 21164A 600 MHz:         12.8 ms


     For regular users we want to target between 250-500ms per hash (i.e. no more than 500 ms, no less than 250 ms)
     We would like to target 300ms as the calculation time, but not exceed 500ms.

     - if our calculation time was less than 250ms, then we can double it
     - if our calculation time was more than 500ms, then we can half it

     Speed of pins
     =============

     For a 5-digit pin (59,049 combinations) the time to exhaust all combinations is:
     200 ms --> 3.2 hours
     250 ms --> 4.1 hours
     400 ms --> 6.6 hours
     500 ms --> 8.2 hours
   }
   Result := BCRYPT_COST; // never recommend lower than the fixed BCRYPT_COST

   if (SampleCost <= 0) or (SampleHashDurationMS <= 0) then
      Exit;

   // while the duration is too low, double it
   while SampleHashDurationMS < 250 do
   begin
      Inc(SampleCost);
      SampleHashDurationMS := SampleHashDurationMS * 2;
   end;

   // if the duration is too high, halve it (as long as we are still above the minumum cost)
   while (SampleHashDurationMS > 500) and (SampleCost > BCRYPT_COST) do
   begin
      Dec(SampleCost);
      SampleHashDurationMS := SampleHashDurationMS / 2;
   end;

   Result := SampleCost;
end;

class function TBCrypt.GetModernCost_Benchmark: Integer;
var
   t1, t2, freq: Int64;
const
   testCost = 5; // 4;
begin
   {
     Run a quick benchmark on the current machine to see how fast this PC is.
     A cost of 4 is the lowest we allow, so we will hash with that.

     The problem with the Moore's Law approach, is that Moore's Law failed in 2004:
     http://preshing.com/20120208/a-look-back-at-single-threaded-cpu-performance/
     http://preshing.com/images/float-point-perf.png
   }
   Result := BCRYPT_COST; // don't ever go less than the default cost

   if not QueryPerformanceFrequency( { var } freq) then
      Exit;
   if (freq = 0) then
      Exit;
   if not QueryPerformanceCounter(t1) then
      Exit;
   if (t1 = 0) then
      Exit;

   TBCrypt.HashPassword('Benchmark', testCost);

   if not QueryPerformanceCounter(t2) then
      Exit;
   if t2 = 0 then
      Exit;

   Result := TBCrypt.GetModernCost(testCost, (t2 - t1) / freq * 1000);
end;

class function TBCrypt.SelfTestD: Boolean;
var
   i: Integer;
   Password: string;
   hash: string;
begin
   for i := 0 to 56 do
   begin
      Password :=
        Copy('The quick brown fox jumped over the lazy dog then sat on a log',
        1, i);
      hash := TBCrypt.HashPassword(Password, 4);
      if (hash = '') then
         raise Exception.Create('hash creation failed');
   end;

   Result := True;
end;

class function TBCrypt.SelfTestE: Boolean;
var
   Salt: TBytes;
begin
   {
     Ensure that the salt generator creates salt, and it is of the correct length.
   }
   Salt := TBCrypt.GenerateSalt;
   if Length(Salt) <> BCRYPT_SALT_LEN then
      raise Exception.Create('BCrypt selftest failed; invalid salt length');

   Result := True;
end;

class function TBCrypt.SelfTestF: Boolean;
var
   rehashNeeded: Boolean;
begin
   {
     Validate a known password hash
   }
   // OutputDebugString('SAMPLING ON');
   Result := TBCrypt.CheckPassword('correctbatteryhorsestapler',
     '$2a$12$mACnM5lzNigHMaf7O1py1O3vlf6.BA8k8x3IoJ.Tq3IB/2e7g61Km',
     { out } rehashNeeded);
   // OutputDebugString('SAMPLING OFF');
end;

class function TBCrypt.SelfTestG: Boolean;
var
   s55, s56, s57: TBytes;
   s70, s71, s72, s73, s74: TBytes;
   sCopy: TBytes;
   Salt: TBytes;

   function BytesEqual(const data1, data2: array of Byte): Boolean;
   begin
      Result := True;

      if Length(data1) <> Length(data2) then
      begin
         Result := False;
         Exit;
      end;

      if Length(data1) = 0 then
         Exit;

      Result := CompareMem(@data1[0], @data2[0], Length(data1))
   end;

const
   testPassword =
     'The quick brown fox jumped over the lazy dog then sat on a log. The sixth sick';
   // 56^               ^72
begin
   Result := True;

   Salt := TBCrypt.GenerateSalt;

   s55 := TBCrypt.HashPassword(Copy(testPassword, 1, 55), Salt, 4);
   s56 := TBCrypt.HashPassword(Copy(testPassword, 1, 56), Salt, 4);
   s57 := TBCrypt.HashPassword(Copy(testPassword, 1, 57), Salt, 4);

   // First make sure that we can generate the same hash twice with the same password and salt
   sCopy := TBCrypt.HashPassword(Copy(testPassword, 1, 55), Salt, 4);
   if not BytesEqual(s55, sCopy) then
      Result := False;

   // The old limit was 56 byte (55 characters + 1 null terminator). Make sure that we can at least handle 57
   if BytesEqual(s55, s56) then
      Result := False;
   if BytesEqual(s56, s57) then
      Result := False;

   // Finally, do the same test around the 72 character limit. If you specify more than 71 characters, it is cut off
   // 20161025: Change to match what OpenBSD does: they cut off the byte array - null terminator and all - after 72 bytes
   s70 := TBCrypt.HashPassword(Copy(testPassword, 1, 70), Salt, 4);
   s71 := TBCrypt.HashPassword(Copy(testPassword, 1, 71), Salt, 4);
   s72 := TBCrypt.HashPassword(Copy(testPassword, 1, 72), Salt, 4);
   s73 := TBCrypt.HashPassword(Copy(testPassword, 1, 73), Salt, 4);
   s74 := TBCrypt.HashPassword(Copy(testPassword, 1, 74), Salt, 4);

   if BytesEqual(s70, s71) then // we should have still had room
      Result := False;

   if BytesEqual(s71, s72) then
   // the 72 character version has no room for the null terminator anymore, so it's also going to be different
      Result := False;

   if not BytesEqual(s72, s73) then // we should have stopped at 72 characters
      Result := False;
   if not BytesEqual(s72, s74) then // definitely don't overflow into 74
      Result := False;
end;

class function TBCrypt.SelfTestH: Boolean;
var
   szPassword: string;
   rehashNeeded: Boolean;
begin
   {
     A bug was discovered in the OpenBSD implemenation of bcrypt in February of 2014

     http://undeadly.org/cgi?action=article&sid=20140224132743
     http://marc.info/?l=openbsd-misc&m=139320023202696

     They were storing the length of their strings in an unsigned char (i.e. 0..255)
     If a password was longer than 255 characters, it would overflow and wrap at 255.

     They fixed their bug, and decided that everyone should use a new version string (2b).

     Delphi doesn't have this problem, because Delphi does strings correctly (length prefixed, null terminated, reference counted)
   }
   szPassword := StringOfChar('a', 260);

   Result := TBCrypt.CheckPassword(szPassword,
     '$2a$04$QqpSfI8JYX8HSxNwW5yx8Ohp12sNboonE6e5jfnGZ0fD4ZZwQkOOK',
     { out } rehashNeeded);
end;

class function TBCrypt.SelfTestI: Boolean;
var
   Password: UnicodeString;
   utf8: TBytes;
const
   n: UnicodeString = ''; // n=nothing.
   // Work around bug in Delphi compiler when building widestrings
   // http://stackoverflow.com/a/7031942/12597
begin
   {
     Before: A + ¨ + fi + n
     A:  U+0041
     ¨:  U+0308 Combining Diaeresis
     fi: U+FB01 Latin Small Ligature Fi
     n:  U+006E

     Normalized:  Ä + f + i + n
     Ä:  U+00C4  Latin Capital Letter A with Diaeresis
     f:  U+0066
     i:  U+0069
     n:  U+006E

     Final UTF-8:
     Ä:  0xC3 0x84
     f:  0x66
     i:  0x69
     n:  0x6E
     \0: 0x00
   }
   Password := n + WideChar('A') + WideChar(#$0308) + WideChar(#$FB01) +
     WideChar('n');

   utf8 := TBCrypt.PasswordStringPrep(Password);

   {
     0xC3 0x84 0x66 0x69 0x6E 0x00
   }
   Result := (Length(utf8) = 6);
   Result := Result and (utf8[0] = $C3);
   Result := Result and (utf8[1] = $84);
   Result := Result and (utf8[2] = $66);
   Result := Result and (utf8[3] = $69);
   Result := Result and (utf8[4] = $6E);
   Result := Result and (utf8[5] = $00); // we do include the null terminator
end;

class function TBCrypt.SelfTestJ: Boolean;
var
   password1: UnicodeString;
   password2: UnicodeString;
   hash: string;
   PasswordRehashNeeded: Boolean;
const
   n: UnicodeString = ''; // n=nothing.
   // Work around bug in Delphi compiler when building widestrings
   // http://stackoverflow.com/a/7031942/12597
begin
   {
     There are four Unicode normalization schemes:

     NFC	Composition
     NFD	Decomposition
     NFKC	Compatible Composition   <--- the one we use
     NFKD	Compatible Decomposition

     NIST Special Publication 800-63-3B (Digital Authentication Guideline - Authentication and Lifecycle Management)
     says that passwords should have unicode normalization KC or KD applied.

     RFC7613 (SASLprep) specifies the use of NFKC
     https://tools.ietf.org/html/rfc7613
     Preparation, Enforcement, and Comparison of Internationalized Strings Representing Usernames and Passwords

     Original
     A:  U+0041
     ¨:  U+0308 Combining Diaeresis
     fi: U+FB01 Latin Small Ligature Fi
     n:  U+006E

     Normalized:  Ä + f + i + n
     Ä:  U+00C4  Latin Capital Letter A with Diaeresis
     f:  U+0066
     i:  U+0069
     n:  U+006E
   }
   password1 := n + 'A' + #$0308 + #$FB01 + 'n';
   password2 := n + #$00C4 + 'f' + 'i' + 'n';

   hash := TBCrypt.HashPassword(password1, 4);

   Result := TBCrypt.CheckPassword(password2, hash,
     { out } PasswordRehashNeeded);
end;

class function TBCrypt.SelfTestK: Boolean;
var
   pass: UnicodeString;

   function CheckUtf8(const s: UnicodeString; Expected: array of Byte): Boolean;
   var
      data: TBytes;
   begin
      Result := False;

      data := TBCrypt.PasswordStringPrep(s);

      if Length(data) <> Length(Expected) then
         Exit;

      if not CompareMem(@data[0], @Expected[0], Length(data)) then
         Exit;

      Result := True;
   end;

begin
   {
     1. Width-Mapping Rule: Fullwidth and halfwidth characters MUST NOT be mapped to their decomposition mappings
     (see Unicode Standard Annex #11 [UAX11](https://tools.ietf.org/html/rfc7613#ref-UAX11)).
   }

   Result := True;

   {
     Fullwidth "Test"

     U+FF34  FULLWIDTH LATIN CAPITAL LETTER T   UTF8 0xEF 0xBC 0xB4
     U+FF45  FULLWIDTH LATIN SMALL LETTER   e   UTF8 0xEF 0xBD 0x85
     U+FF53  FULLWIDTH LATIN SMALL LETTER   s   UTF8 0xEF 0xBD 0x93
     U+FF54  FULLWIDTH LATIN SMALL LETTER   t   UTF8 0xEF 0xBD 0x94
   }
   // pass := #$ff34 + #$ff45 + #$ff53 + #$ff54;
   // if not CheckUtf8(pass, [$ef, $bc, $b4, $ef, $bd, $85, $bd, $93, $ef, $bd, $94, 0]) then Result := False;

   {
     Halfwidth
     U+FFC3  HALFWIDTH HANGUL LETTER AE         UTF8 0xEF 0xBF 0x83
   }
   // pass := #$ffc3;
   // if not CheckUtf8(pass, [$ef, $bf, $83, 0]) then Result := False;

   {
     2.  Additional Mapping Rule: Any instances of non-ASCII space MUST be mapped to ASCII space (U+0020);
     a non-ASCII space is any Unicode code point having a Unicode general category of "Zs"
     (with the  exception of U+0020).

     U+0020	SPACE
     U+00A0	NO-BREAK SPACE
     U+1680	OGHAM SPACE MARK
     U+2000	EN QUAD
     U+2001	EM QUAD
     U+2002	EN SPACE
     U+2003	EM SPACE
     U+2004	THREE-PER-EM SPACE
     U+2005	FOUR-PER-EM SPACE
     U+2006	SIX-PER-EM SPACE
     U+2007	FIGURE SPACE
     U+2008	PUNCTUATION SPACE
     U+2009	THIN SPACE
     U+200A	HAIR SPACE
     U+202F	NARROW NO-BREAK SPACE
     U+205F	MEDIUM MATHEMATICAL SPACE
     U+3000	IDEOGRAPHIC SPACE
   }
   pass := #$0020;
   if not CheckUtf8(pass, [$20, 0]) then
      Result := False;
   pass := #$00A0;
   if not CheckUtf8(pass, [$20, 0]) then
      Result := False;
   pass := #$2000;
   if not CheckUtf8(pass, [$20, 0]) then
      Result := False;
end;

class function TBCrypt.SelfTestL: Boolean;
var
   actual: string;
   data: TBytes;
begin
   {
     From passlib.hash.bcrypt_sha256 - BCrypt+SHA256
     https://passlib.readthedocs.io/en/stable/lib/passlib.hash.bcrypt_sha256.html


     Input: "password"
     Expected: "XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg="
   }

   // utf8 version of "password"
   SetLength(data, 8);
   data[0] := Ord('p');
   data[1] := Ord('a');
   data[2] := Ord('s');
   data[3] := Ord('s');
   data[4] := Ord('w');
   data[5] := Ord('o');
   data[6] := Ord('r');
   data[7] := Ord('d');

   actual := TBCrypt.HashBytes256(data);

   Result := ('XohImNooBHFR0OVvjcYpJ3NgPQ1qq73WKhHvch0VQtg=' = actual);
end;

class function TBCrypt.PasswordRehashNeeded(const hashString: string): Boolean;
var
   idealCost: Integer;
   version: string;
   Cost: Integer;
   Salt: TBytes;
   IsEnhanced: Boolean;
begin
   {
     As computing power increases, we might from time to time need to increase the cost factor.
     Run a microbenchmark to get the desired cost factor, and compare it to the cost factor stored in the Hash.

     If the desired cost is higher, then we need to rehash.
     The time to do this is after we have validated the user's credentials. This way we can silently rehash their
     known good password.
   }
   if not TBCrypt.TryParseHashString(hashString, { out } version, { out } Cost,
     { out } Salt, { out } IsEnhanced) then
   begin
      // raise EBCryptException.Create('PasswordRehashNeeded: Could not parse Hash string');
      Result := True;
      // if they expected it to be a valid BCrypt hash, and it's not, then they definitely need to rehash something
      Exit;
   end;

   idealCost := TBCrypt.GetModernCost_Benchmark;

   if (Cost < idealCost) then
   begin
      Result := True;
      Exit;
   end;

   Result := False;
end;

class function TBCrypt.PasswordRehashNeededCore(const version: string;
  const Cost: Integer; SampleCost: Integer; SampleHashDurationMS: Real)
  : Boolean;
var
   idealCost: Integer;
begin
   {
     This core routine is used by two paths:
     - checking a real password, where we are passed the actual cost
   }
   // If the cost is lower than our hard-coded minimum, then they need to rehash
   if Cost < BCRYPT_COST then
   begin
      Result := True;
      Exit;
   end;

   if AnsiSameText(version, '2')
   // original spec, that didn't define UTF-8 or what to do with a null terminator
     or AnsiSameText(version, '2x')
   // hashes generated by a buggy version of crypt_blowfish; didn't handle unicode correctly
     or AnsiSameText(version, '2y') // fixed version of crypt_blowfish
   // or AnsiSameText(version, '2a') //buggy version of OpenBSD that stored password length in a Byte
   then
   begin
      // It should be version 2a. (eventually will be moved to 2b)
      Result := True;
      Exit;
   end;

   // Use the supplied hashing time as a benchmark
   if (SampleCost > 0) and (SampleHashDurationMS > 0) then
   begin
      idealCost := GetModernCost(SampleCost, SampleHashDurationMS);
      if (idealCost > Cost) then
      begin
         Result := True;
         Exit;
      end;
   end;

   Result := False; // no rehash needed
end;

class function TBCrypt.TimingSafeSameString(const Safe, User: string): Boolean;
var
   i: Integer;
   safeLen, userLen: Integer;
   nDiff: Integer;
begin
   {
     A timing safe equals comparison

     To prevent leaking length information, it is important that user input is always used as the second parameter.

     safe The internal (safe) value to be checked
     user The user submitted (unsafe) value

     Returns True if the two strings are identical.
   }

   safeLen := Length(Safe);
   userLen := Length(User);

   // Set the result to the difference between the lengths
   nDiff := safeLen - userLen;

   // Note that we ALWAYS iterate over the user-supplied length
   // This is to prevent leaking length information
   for i := 0 to userLen - 1 do
   begin
      // Using mod here is a trick to prevent notices.
      // It's safe, since if the lengths are different nDiff is already non-zero
      nDiff := nDiff or (Ord(Safe[(i mod safeLen) + 1]) xor Ord(User[i + 1]));
   end;

   // They are only identical strings if nDiff is exactly zero
   Result := (nDiff = 0);
end;

{$IFDEF BCryptUnitTests}
{ TBCryptTests }

procedure TBCryptTests.Benchmark;
var
   Cost: Integer;
   t1, t2, freq: Int64;
   durationMS: Double;
begin
   if not FindCmdLineSwitch('SlowUnitTests', ['/', '-'], True) then
   begin
      Status('Very slow test. Specify -SlowUnitTests to include');
      Exit;
   end;

   if not QueryPerformanceFrequency(freq) then
      freq := -1; // to avoid division by zero

   Status('Cost factor	Duration (ms)');

   Cost := 4; // the minimum supported bcrypt cost

   OutputDebugString('SAMPLING ON');
   while (Cost <= 16 { 31 } ) do
   begin
      QueryPerformanceCounter( { out } t1);
      TBCrypt.HashPassword('benchmark', Cost);
      QueryPerformanceCounter( { out } t2);

      durationMS := (t2 - t1) / freq * 1000;

      Status(Format('%d	%.4f', [Cost, durationMS]));

      Inc(Cost);

      if durationMS > 15000 then
         Break;
   end;
   OutputDebugString('SAMPLING OFF');

   Status(Self.GetCompilerOptions);
end;

function TBCryptTests.GetCompilerOptions: string;

   procedure Add(s: string);
   begin
      if Result <> '' then
         Result := Result + #13#10;

      Result := Result + s;
   end;

begin
   Result := '';

   (*
     Other than for certain debugging situations, you should never have a need to turn optimizations off.
   *)
{$IFOPT O+} // OPTIMIZATION
   Add('Optimization: ON');
{$ELSE}
Add('Optimization: OFF');
{$ENDIF}
(*
  Enabling overflow checking slows down your program and makes it somewhat larger, so use {$Q+} only for debugging.
*)
{$IFOPT Q+} // OVERFLOWCHECKS
Add('Overflow Checking: ON');
{$ELSE}
Add('Overflow Checking: OFF');
{$ENDIF}
(*
  Enabling range checking slows down your program and makes it somewhat larger.
*)
{$IFOPT R+} // RANGECHECKS
Add('Range Checking: ON');
{$ELSE}
Add('Range Checking: OFF');
{$ENDIF}
{$IFOPT W+} // STACKFRAMES
Add('Stack frames: ON');
{$ELSE}
Add('Stack frames: OFF');
{$ENDIF}
{$IFOPT I+} // IOCHECKS
Add('I/O Checking: ON');
{$ELSE}
Add('I/O Checking: OFF');
{$ENDIF}
end;

procedure TBCryptTests.SelfTest;
begin
   CheckTrue(TBCrypt.SelfTest);
end;

procedure TBCryptTests.SelfTestA_KnownTestVectors;
begin
   if not FindCmdLineSwitch('SlowUnitTests', ['/', '-'], True) then
   begin
      Status('Very slow test. Specify -SlowUnitTests to include');
      Exit;
   end;

   CheckTrue(TBCrypt.SelfTestA);
end;

procedure TBCryptTests.SelfTestB_Base64EncoderDecoder;
begin
   CheckTrue(TBCrypt.SelfTestB);
end;

procedure TBCryptTests.SelfTestC_UnicodeStrings;
begin
   if not FindCmdLineSwitch('SlowUnitTests', ['/', '-'], True) then
   begin
      Status('Very slow test. Specify -SlowUnitTests to include');
      Exit;
   end;

   CheckTrue(TBCrypt.SelfTestC);
end;

procedure TBCryptTests.SelfTestD_VariableLengthPasswords;
begin
   CheckTrue(TBCrypt.SelfTestD);
end;

procedure TBCryptTests.SelfTestE_SaltRNG;
begin
   CheckTrue(TBCrypt.SelfTestE);
end;

procedure TBCryptTests.SelfTestF_CorrectBattery;
var
   t1, t2, freq: Int64;
begin
   if not QueryPerformanceFrequency(freq) then
      freq := -1; // to avoid division by zero

   QueryPerformanceCounter(t1);
   CheckTrue(TBCrypt.SelfTestF);
   QueryPerformanceCounter(t2);

   Status(Format('%.4f ms', [(t2 - t1) / freq * 1000]));

   Status(GetCompilerOptions);
end;

procedure TBCryptTests.SelfTestG_PasswordLength;
begin
   CheckTrue(TBCrypt.SelfTestG);
end;

procedure TBCryptTests.SelfTestH_OpenBSDLengthBug;
begin
   CheckTrue(TBCrypt.SelfTestH);
end;

procedure TBCryptTests.SelfTestI_UnicodeCompatibleComposition;
begin
   CheckTrue(TBCrypt.SelfTestI);
end;

procedure TBCryptTests.SelfTestJ_NormalizedPasswordsMatch;
begin
   CheckTrue(TBCrypt.SelfTestJ);
end;

procedure TBCryptTests.SelfTestK_SASLprep;
begin
   CheckTrue(TBCrypt.SelfTestK);
end;

procedure TBCryptTests.SelfTestL_Prehash;
begin
   CheckTrue(TBCrypt.SelfTestL);
end;

procedure TBCryptTests.SpeedTests;
var
   freq: Int64;

   procedure TimeIt(Cost: Integer);
   var
      t1, t2: Int64;
      timems: Real;
      bestTime: Real;
      n: Integer;
   begin
      bestTime := 0;

      n := 5;
      while n > 0 do
      begin
         QueryPerformanceCounter(t1);
         TBCrypt.HashPassword('corrent horse battery staple', Cost);
         QueryPerformanceCounter(t2);

         Dec(n);

         timems := (t2 - t1) / freq * 1000; // milliseconds
         if (bestTime = 0) or (timems < bestTime) then
         begin
            bestTime := timems;
            n := 5; // we found a new min. Wait until we get five min in a row
         end;
      end;

      Status(Format('BCrypt, cost=%d: %.2f ms', [Cost, bestTime]));
   end;

begin
   if not QueryPerformanceFrequency(freq) then
      freq := -1;
   // negative one, so that a division results in negative ticks, rather than infinite or exception

   TimeIt(8);
   TimeIt(9);
   TimeIt(10);
   TimeIt(11);
   TimeIt(12);
   TimeIt(13);
   TimeIt(14);
   TimeIt(15);
   // OutputDebugString('SAMPLING ON');
   TimeIt(16);
   // OutputDebugString('SAMPLING OFF');
   // TimeIt(17);
end;

procedure TBCryptTests.TestEnhancedHash;
var
   expectedHash: string;
   PasswordRehashNeeded: Boolean;
   passwordValid: Boolean;
begin
   expectedHash := TBCrypt.EnhancedHashPassword('correct battery horse staple');
   CheckTrue(expectedHash <> '');

   passwordValid := TBCrypt.CheckPassword('correct battery horse staple',
     expectedHash, { out } PasswordRehashNeeded);
   CheckTrue(passwordValid);
end;

procedure TBCryptTests.TestParseEnhancedHash;
var
   bRes: Boolean;
   hash: string;
   version: string;
   Cost: Integer;
   actualSalt: TBytes;
   actualSaltBase64: string;
   IsEnhanced: Boolean;
begin
   hash := '$bcrypt-sha256$2a,12$LrmaIX5x4TRtAwEfwJZa1.$2ehnw6LvuIUTM0iz4iz9hTxv21B6KFO';

   bRes := TBCrypt.TryParseHashString(hash, { out } version, { out } Cost,
     { out } actualSalt, { out } IsEnhanced);
   CheckTrue(bRes);

   CheckEquals('2a', version);
   CheckEquals(12, Cost);
   CheckEquals(True, IsEnhanced); // is enhanced

   actualSaltBase64 := TBCrypt.BsdBase64Encode(actualSalt, Length(actualSalt));
   CheckEquals('LrmaIX5x4TRtAwEfwJZa1.', actualSaltBase64);
end;

procedure TBCryptTests.Test_ManualSystem;
var
   Salt: TBytes;
   hash: TBytes;
   Password: string;
   validPassword: Boolean;
   PasswordRehashNeeded: Boolean;
begin
   {
     Normally bcrypt hashes to an OpenBSD password-file compatible string (i.e. $2b$...)
     But if you want to handle the salt, and hash bytes directly, and come up with your own serialization format
     you can do that too
   }
   Password := 'correct horse battery staple';
   Salt := TBCrypt.GenerateSalt;

   hash := TBCrypt.HashPassword(Password, Salt, 4);
   // 4 is the lowest cost we'll accept

   validPassword := TBCrypt.CheckPassword(Password, Salt, hash, 4,
     { out } PasswordRehashNeeded);
   CheckTrue(validPassword);
   CheckTrue(PasswordRehashNeeded,
     'Expected passwordRehashNeede to be true, given that we used a cost of 4');
end;

procedure TBCryptTests.Test_ParseHashString;

   procedure t(hashString: string; ExpectedResult: Boolean;
     ExpectedVersion: string; ExpectedCost: Integer; ExpectedSaltBase64: string;
     TestSituation: string);
   var
      actualVersion: string;
      actualCost: Integer;
      actualSalt: TBytes;
      actualIsEnhanced: Boolean;
      actualSaltBase64: string;
      actualResult: Boolean;
   begin
      // expectedSalt := TBCrypt.BsdBase64Decode(ExpectedSaltBase64);
      actualResult := TBCrypt.TryParseHashString(hashString,
        { out } actualVersion, { out } actualCost, { out } actualSalt,
        { out } actualIsEnhanced);

      CheckEquals(ExpectedResult, actualResult, hashString + '   ' +
        TestSituation);
      if actualResult then
      begin
         CheckEquals(ExpectedVersion, actualVersion, 'Version for hash: ' +
           hashString + '   ' + TestSituation);
         CheckEquals(ExpectedCost, actualCost, 'Cost for hash: ' + hashString +
           '   ' + TestSituation);

         actualSaltBase64 := TBCrypt.BsdBase64Encode(actualSalt,
           Length(actualSalt));
         CheckEquals(ExpectedSaltBase64, actualSaltBase64,
           'Salt for hash: ' + hashString + '   ' + TestSituation);

         // These are non-enhanced hash strings (expect False)
         CheckEquals(False, actualIsEnhanced, 'Is Enhanced for hash: ' +
           hashString + '	' + TestSituation);
      end;
   end;

begin
   t('$2c$06$DCq7YPn5Rq63x1Lad4cll.', True, '2c', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Future version suffix - 2c');
   t('$2b$06$DCq7YPn5Rq63x1Lad4cll.', True, '2b', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Current version suffix - 2b');
   t('$2a$06$DCq7YPn5Rq63x1Lad4cll.', True, '2a', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Most common version suffix - 2a');
   t('$2y$06$DCq7YPn5Rq63x1Lad4cll.', True, '2y', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Crypt_blowfish fixed hash version - 2y');
   t('$2x$06$DCq7YPn5Rq63x1Lad4cll.', True, '2x', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Crypt_blowfish buggy hash version - 2x');
   t('$2$06$DCq7YPn5Rq63x1Lad4cll.', True, '2', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Original bcrypt version - 2');

   t('$2c$6$DCq7YPn5Rq63x1Lad4cll.', True, '2c', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Single digit cost factor "6"');
   t('$2b$06$DCq7YPn5Rq63x1Lad4cll.', True, '2b', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Two digit cost factor "06"');
   t('$2a$006$DCq7YPn5Rq63x1Lad4cll.', True, '2a', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Triple digit cost factor "006"');

   t('$2c$0$DCq7YPn5Rq63x1Lad4cll.', False, '2c', 0, 'DCq7YPn5Rq63x1Lad4cll.',
     'Zero cost factor is not valid');
   t('$2c$$DCq7YPn5Rq63x1Lad4cll.', False, '2c', 0, 'DCq7YPn5Rq63x1Lad4cll.',
     'Empty cost factor is not valid');

   t('$3$6$DCq7YPn5Rq63x1Lad4cll.', False, '3', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Unknown version number');
   t('$20$6$DCq7YPn5Rq63x1Lad4cll.', False, '20', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Version suffix can only be a letter');
   t('$2_$6$DCq7YPn5Rq63x1Lad4cll.', False, '2_', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Version suffix can only be a letter');
   t('$2ca$6$DCq7YPn5Rq63x1Lad4cll.', False, '2ca', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Version string can be at most 2 characters ("2" + "letter")');

   t('$2C$6$DCq7YPn5Rq63x1Lad4cll.', True, '2C', 6, 'DCq7YPn5Rq63x1Lad4cll.',
     'Version suffix may also be UPPERCASE');

   t('$2a', False, '2a', 0, '', 'Missing everything after version');
   t('$2a$', False, '2a', 0, '', 'Missing everything after version');
   t('$2a$6', False, '2a', 6, '', 'Missing everything after cost factor');
   t('$2a$6$', False, '2a', 6, '', 'Missing everything after cost factor');
   t('$2a$6$DCq7YPn5Rq63x1Lad4cll', False, '2a', 6, 'DCq7YPn5Rq63x1Lad4cll',
     'Salt is too short');
end;

{$ENDIF}

initialization

{$IFDEF BCryptUnitTests}
  RegisterTest('Library', TBCryptTests.Suite);
{$ENDIF}

{
  This is free and unencumbered software released into the public domain.

  Anyone is free to copy, modify, publish, use, compile, sell, or
  distribute this software, either in source code form or as a compiled
  binary, for any purpose, commercial or non-commercial, and by any
  means.

  In jurisdictions that recognize copyright laws, the author or authors
  of this software dedicate any and all copyright interest in the
  software to the public domain. We make this dedication for the benefit
  of the public at large and to the detriment of our heirs and
  successors. We intend this dedication to be an overt act of
  relinquishment in perpetuity of all present and future rights to this
  software under copyright law.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  OTHER DEALINGS IN THE SOFTWARE.

  For more information, please refer to <http://unlicense.org/>
}
end.
