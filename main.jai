#import "Basic";

// Constant main function
main :: () {
    print("Hello, World!\n");
}

// :: Constant assigned operator - 2 is assigned to B or B i equal to 2
B :: 2; 

// Modules can be assigned to identifieers
Math :: #import "Math";

// Then everything inside the module will be namespaced with the given name, e.g.
Math.sqrt();

// #Load - Loads any file content into the calling file (Copy/Paste into the calling file)
#load "file_a.jai";
#load "file_b.jai";

// Named #import
Math :: #import "Math";
y := Math.sqrt(2.0);

// Load a file with a known filename, without searching the import_path. [???]
module :: #import, dir "files/directory";

// This loads a directory-style module from a specific path. [???]
#import, string "factorial :: (x: int) -> int {
    if x <= 1 return 1; return x*factorial(x-1);
 }";

// Variables are defined using the := operator, which allows you to specify a type and a value for your new variable, e.g. name : type = value;
a : int = 3;
b : string = "hello";

// Inferred types
a := 3;         // Inferred as int.
b := 3.1415;    // Inferred as float.
c := "hello";   // Inferred as string.
d : string;     // Defaults to empty string, "".
e : *u32;       // Defaults to a null pointer to a u32.
f := #char "1"; // Inferred as s64. f has the value of the ASCII character '1'

// Splitting the :: to specify the type if you want to be precise. e.g.
PI :: 3.141592
my_word : u16 : 65535;

// Basic Types
/*
    bool - a boolean, that can take values true or false. This value takes up 8 bits of memory.
    s8, u8 - signed and unsigned 8 bit integers. [???]
    s16, u16 - signed and unsigned 16 bit integers.
    s32, u32 - signed and unsigned 32 bit integers.
    s64, u64 - signed and unsigned 64 bit integers.
    float32 - 32 bit floating point number.
    float64 - 64 bit floating point number.
    string - a string, an array view of u8. Jai strings are NOT zero-terminated
*/


//// ASSIGNMENT

mynumber := 5; // Declare variable
mynumber = 17; // Assign 17 to variable.

// Arithmetic operators +, -, *, / and %
// +=, -=, *=, /= and %=

// Compound Assignments "a, b = b, a" -  Will swap elements
// This also works for longer sequences with arbitrary permutations.
// All right hand side values are evaluated in the first pass, and then assignments are done to the left hand side values on the second pass.

//// BOOLEAN AND BITWISE OPERATORS

/*
    ! - boolean NOT
    || - boolean OR
    && - boolean AND

    Additionally, it has a number of bitwise operators:

    | - bitwise OR
    & - bitwise AND
    ^ - bitwise XOR
    << - shift left
    <<< - rotate left
    >> - shift right
    >>> - rotate right
    ~ - bitwise NOT (one's complement) (unary)

*/


/*  
    Example:
    Bitwise AND compares the respective bits between two numbers together. 
    If both respective bits are 1, then the output is 1. If either respective bits are 0, then the output is zero.
*/

  11001100
& 10001000
----------
= 10001000

/*  
    Example:
    Bitwise OR compares the respective bits between two numbers together.
    If either respective bits are 1, then the output is 1. If both respective bits are 0, then the output is zero.
*/

  11001100
| 10000011
----------
= 11001111


// NUMBER LITERALS

/*
    A :: 10;   // here's a 10
    C :: 0b10; // this is 2 in binary
    B :: 0x10; // and this is 16 in hexadecimal
    D :: 0b1010_0010_0101_1111;
    E :: 0xFFFF_FF_FF;      // This is inconsistent and weird, but legal.
    F :: 16_777_216;
*/

// STRINGS

/*
    Strings are a datatype representing a sequence of characters, where each character is a byte, or u8. Here is the definition for a string:
*/

string :: struct {
  count: int;
  data: *u8;
}

// MULTI LINE STRING

multi_line_string := #string END_STRING
This
is
a
multi-line
string.
END_STRING;

print(multi_line_string);

// result

This
is
a
multi-line
string.

// Strings as boolean values

/*
    Strings implicitly cast to boolean values that can be then used in if statements.
    If str has characters in it, then the automatic cast to boolean is true.
    Otherwise if str is an empty string, it is false.
*/

str : string = "Hello.";
if str {

} else {

}


//// STRING OPERATIONS

//// String comparing functions
// "equal" checks if two strings are equal. Returns true if both strings are equal. Returns false if not equal.
equal :: (a: string, b: string) -> bool;    

// "compare" compares two strings a and b. Returns -1 if a is less than b, 1 if a is greater than b, and 0 if they are equal.    
compare :: (a: string, b: string) -> int;    

// "contains" returns true if the string contains substring.
contains :: (str: string, substring: string) -> bool;

//// string begins with and ends with function
// "begins_with" - checks if a given string begins with a specified prefix. 
begins_with :: (str: string, prefix: string) -> bool;

// "ends_with" - checks if a given string ends with a specified suffix.
end_with :: (str: string, suffix: string) -> bool;

//// Concatenating and splitting strings
// "join" - Joins all the string inputs together to form a  larger string.  For example: join("a","b","c","d") outputs "abcd". 
join :: (inputs: .. string, separator := "", before_first := false, after_last := false) -> string;

// "split" - Splits an input string according to a separator.
split :: (str: string, separator: string) -> [] string;


//// STRING MANIPULATION

// string to int/float and parsing functions
string_to_int :: (str: string) -> int, bool;
string_to_float :: (str: string) -> float, bool;
parse_float :: (line: *string) -> float, bool;
parse_int :: (line: *string) -> int, bool;
parse_token :: (line: *string) -> string, bool;

// Attempts to parse a string into a float, token, or int.

// c string manipulation functions
to_c_string :: (str: string) -> *u8; // NOTE: This function heap allocates memory
c_style_strlen :: (ptr: *u8) -> int;

// These functions manipulate c-strings received from c-libraries


//// ANY TYPE

/*
    The Any Type is a type that is matches against all other types in the language.
    Structs, primitives, strings, arrays, array views, and dynamic arrays are all auto castable to Any Type.
    
    Take for example the print function in the Basic module:
*/

print :: (fmt: string, param: ..Any) {
    //..
}

/*
    The print function takes in a variable number of type Any parameters at compile time, and the type information is available at runtime.
    The Any Type is a struct of two values: the type info and the pointer to the value.
*/

Any :: struct {
    type: *Type_Info;
    value_pointer: *void;
}

// When you assign a variable to Any, it translates to the following:

number: int = 8;
any: Any;
any = number;

// these two expressions are the same.
any.type = type_of(number);
any.value_pointer = *number;


//// CASTING

/*
    The type system in Jai is fairly strict. Types, though similar, may need explicit casting if there is any risk of loss of information.
    Therefore, you can cast a u16 to a u32 implicitly, but you can't cast a u32 to a u16 without being explicit about it,
    and the compiler will give you an error if you attempt to.
*/

// Instread, you can use cast(), like so:

a: u32 = 50000;
b : u16;

b = cast(u16) a;

// ERROR with bigger value like a = 160000000 - > "Cast bounds check failed.  Number must be in [0, 65535]; it was 16000000.  Site is example.jai:8."
























