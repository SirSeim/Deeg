[![Deeg Logo][deeg-img]][deeg-url]
[![Build Status][travis-img]][travis-url]
[![Codecov][codecov-img]][codecov-url]
[![Dependency Status][dependency-img]][dependency-url]
[![Dev Dependency Status][dev-dependency-img]][dev-dependency-url]

## Introduction
Deeg is a static, object-oriented, strongly-typed language that has powerful and efficient features, including type inferencing, list comprehensions, optionals, string interpolation and first class functions. Deeg compiles nicely into JavaScript. Deeg is the future, and if you don't think so, then you are living in the past, buddy.

## List of Features

- First class functions
- Optional parameters/default parameters
- Terminal 'end' instead of curly braces
- Parenthesis are optional, except for functions
- Optionals
- .deeg file extension
- String Interpolation
- Type Inference
- "make" usage
- Specify type with `:`, optionaly specifying as optional with trailing `?`
- List Comprehensions
- Pattern Matching

### Microsyntax

The rules here are ordered. Matches are attempted from top to bottom.

```
newline        ::= \s* (\r*\n)+
letter         ::= [a-zA-Z]
digit          ::= [0-9]
keyword        ::= 'make' | 'to' 
                 | 'deeg' | 'end' | 'thru' | 'till' | 'by' 
                 | 'and' | 'or' | 'exists' | 'unless' 
                 | 'if'  | 'else' | 'then'
                 | 'not' | 'true' | 'false'
                 | 'for' | 'while' | 'does' | 'count' | 'counts'
                 | 'match' | 'with' 
id             ::= letter (letter | digit | '_')*
intlit         ::= digit+
floatlit       ::= digit+ '.' digit+ <!-- ([Ee] [+-]? digit+)? -->
relop          ::= '<' | '<=' | '==' | '!=' | '>=' | '>'
addop          ::= '+' | '-'
mulop          ::= '*' | '/' | '%'
prefixop       ::= '-' | 'not' | '!'
boollit        ::= 'true' | 'false'
escape         ::= [\\] [rnst'"\\] 
char           ::= [^\p{Cc}'"\\] | escape
stringlit      ::= ('"' char* '"') | (\x27 char* \x27)
comment        ::= '#' [^\n]* newline
                 | '###' .*? '###'
type           ::= 'bool' | 'int' | 'float' | 'string'
```

### Macrosyntax

format can be directly input into Gunther Rademacher's [Railroad Diagram Generator](http://www.bottlecaps.de/rr/ui)

```
Program        ::= Block
Block          ::= (Stmt newline)*

Stmt           ::= WhileStmt | ForStmt | MatchStmt | IfStmt
                 | ReturnStmt
                 | Exp

StdFor         ::= id Type? 'in' Exp ('and' id 'in' Exp)*
CountFor       ::= 'count' Exp
CountsFor      ::= id 'counts' Exp

ReturnStmt     ::= 'deeg' Exp
IfStmt         ::= 'if' Exp 'then' (newline Block | Stmt) ('else if' Exp 'then' (newline Block | Stmt))* ('else' (newline Block | Stmt ))? 'end'
WhileStmt      ::= 'while' Exp 'then' (newline Block 'end' | Stmt 'end')
ForStmt        ::= 'for' (StdFor | CountFor | CountsFor) 'then' (newline Block 'end' | Stmt 'end')
MatchStmt      ::= 'match' id 'with' newline PatBlock

Type           ::= ':' (type | 'Dict' | ('List' (':' Type)?) | ('Function(' (Type (',' Type)*)? ')' (':' Type)?))

Exp            ::= VarDeclaration
                 | VarAssignment
                 | FunctionExp
                 | Exp0

PatBlock       ::= (Patline newline)*

<!-- Patline        ::= '>' (id
                        | WildCard
                        | Head '|' Tail
                 ) Type? ('if')? Exp 'then' Stmt -->

Patline        ::= '>>' Patterns ('if' Exp)? 'then' Stmt
Patterns       ::= Pattern ('|' Pattern)*
Pattern        ::= (id | WildCard) Type?

<!-- WildCard       ::= '_'
Head           ::= id | WildCard
Tail           ::= id | WildCard | (Head '|' Tail) -->

VarDeclaration ::= 'make' id Type? '=' Exp
VarAssignment  ::= VarExp '=' Exp
VarExp         ::= id ( '.' Exp8 
                        | '[' Exp3 ']' 
                        | (Args ('.' Exp8 | '[' Exp3 ']')) )*

Exp0           ::=  Exp1 ('if' Exp1 ('else' Exp1)?)?
Exp1           ::=  Exp2 ('or' Exp2)*
Exp2           ::=  Exp3 ('and' Exp3)*
Exp3           ::=  Exp4 (relop Exp4)?
Exp4           ::=  Exp5 (('thru'|'till') Exp5 ('by' Exp5)?)?
Exp5           ::=  Exp6 (addop Exp6)*
Exp6           ::=  Exp7 (mulop Exp7)*
Exp7           ::=  prefixop? Exp8
Exp8           ::=  Exp9 ('**' Exp5)?
Exp9           ::=  Exp10 ('.' Exp10 | '[' Exp4 ']' | Args)*
Exp10          ::=  boollit | intlit | floatlit | id | '(' Exp ')' | stringlit
                 | DictLit | ListLit

ExpList        ::= newline? Exp (',' newline? Exp)* newline?
ParamList      ::= newline? Exp Type? (',' newline? Exp Type?)* newline?

Args           ::= '(' ExpList ')'
Params         ::= '(' ParamList ')'

ListLit        ::= '[' ExpList? ']'
DictLit        ::= '{' BindingList? '}'
Binding        ::= newline? id Type? 'to' Exp newline?
BindingList    ::= Binding (',' Binding)*

FunctionExp    ::= Params Type? 'does' (newline Block | Stmt) 'end'
```

## Features

### Comments

```
# commented to the end of line
### multi-line comment
    comments
    comments
###
```

### Assignments

```
make example_variable = "this string"
make example_variable2 = 200

make a = 4
make b = 8
a, b = b, a

make c, d = 2, 16
```

### Primitive Types & Reference Types
We have four primitive types: `int` `float` `bool` `string` and however many reference types: `Dict` `Function` `List`

```
make boo = "far"
make hap:string = "py"

make friends_list = ["Bob", "Donna", "Shaggy"]
make grades_list:List:int = [99, 95, 90, 96]

make mapping:Dict = {
    key to "value",
    key2 to 91,
    funKey to (x, y) does deeg x * y,
    funKey2 to (a, b) does
        deeg a + b
    end
}
```

### Type Inference and Static Typing

Hierarchy of types:

int -> float -> string ~> List

This hierarchy is what determines auto conversions. A type can be upconverted automatically if needed. If you want to convert down the tree, then you need to specify it with a type converter function like `int()` or `float()`. Some conversions may return optionals if conversion cannot be guaranteed


```
make year = 99                      # Inferred int
make fraction = 2.5                 # Inferred float
make is_finished = true             # Inferred bool
make name = "Deeg"                  # Inferred string

make grade:float = 95               # Forced to be 95.0
make number_of_people:string = 56   # Forced to be "56"

make grade:int = int(95.0)          # manual conversion down heirarchy
make gpa:int? = int('none')         # ex. converting from strings to nums return optionals
```

### List Comprehensions & Slices

```
[1 thru 10]                         # 1 up to 10, inclusive
[1 till 10]                         # 1 up to 10, exclusive

[1 thru 9 by 3]                     # [1, 4, 7]

make meal:string = "artichokes"
meal[0,1,2]                         # We grab "art"
meal[0 till 3]                      # Since [0 till 3] == [0,1,2] this is also "art"
meal[0 till 8 by 3]                 # We grab "aio"
```

### If Statements

```
if bool_expression then
    # perform action
else
    # other action
end


if bool_expression then
    # action
else if bool_expression then
    # other conditional action
else
    # if nothing else
end

if bool_expression then ###action### else ###else action### end

make interesting_result = "happy times" if bool_expression else "sad times"
```

### For and While Loops

```
for cat in cat_array then
    print("mr. " + cat)
end

for duck in duck_array and dog in dog_array then
    print(duck + " and " + dog)
end

for count int_expression then
    print("hello")
end

for count 5 then
    print("sup")
end



for i counts int_expression then
    print(i + " hello(s)")
end



while is_running then
    runFaster()
end
```

### Functions
In place of a `return` keyword, we have `deeg`.

```
make add_pizazz = (bore:string) does
    deeg bore + "!"
end

make f:Function(int, int):int
f = (a, b) does
    deeg (a, b) = deeg a + b
end

make deeginator = (x, y:float):bool does
    make isAwesome = (x - y * 2 == 69)
    # isAwesome should always be true
    deeg isAwesome
end
```

### Optionals
Optionals are not the default type for variables.

```
make toys = ["bear"]
make unicorn:int? = toys.indexOf("unicorn")

if unicorn exists
    print(unicorn)
else
    print("dreams crushed")
end

make array = ["Hello", "Goodbye"]
make i = array.indexOf("Hi")

###
equivalent to:
make i:int? = array.indexOf("Hi")
###

print(array[i])    # returns error becasue i is i:int? and array[] requires full int

if i exists
    print(array[i])
else
    print("not found")
end

make str = array[i] if i exists else "not found"
```

### Arrays/Lists and Dictionaries

```
make array = ["Hello", "Goodbye"]
make dict = { name to "Bob", age:int to 35, isPresident to false}

dict.name:string                        # every key of a dictionary has a specific type
dict.age:int
dict.isPresident:bool

print(array[0])                         # prints "Hello"
print(array[2])                         # maybe array[2] returns an optional, else this errors

make combo = array + dict               # combo is an object with keys 0 and 1

print(size(dict))                       # prints 3
print(size(array))                      # prints 2
print(size(combo))                      # prints 5

make array_multi = array * 3            # array_multi is ["Hello", "Goodbye", "Hello", "Goodbye", "Hello", "Goodbye"]

make array_combine = array + ["Hi"]     # array_combine is ["Hello", "Goodbye", "Hi"]
make array_alt = ["Hi"] + array         # array_alt is ["Hi", "Hello", "Goodbye"]

make array_str = array + "Hi"           # array_str is ["Hello", "Goodbye", "Hi"]
make arr:List:float = array             # convert to array of floats

make int_array:List:int = [2, 3]        # arrays are homogeneous
make all_dict:Dict = {                  # dictionaries are heterogeneous
    fun:bool to true,
    days to 3
}

print(int_array + all_dict)         
###
prints
{
    0:int to 2,
    1:int to 3,
    days:int to 3,
    fun:bool to true
}
###
```

### Pattern Matching!
```
make func = (x) does
    match x with
        >> 5 then deeg true
        >> 72 then deeg true
        >> _ then deeg false
    end
end


make func = (l) does
    match l with
        >> head|tail if head > 5 then deeg head
        >> _|tail then deeg false
    end
end

make func = (param) does
    match param with
        >> _:int then deeg true
        >> _:float then deeg false
        >> _:string then deeg "Hello, World!"
        >> _ then deeg "Get with the primitives."
    end
end

    
```

## Example Programs

Deeg on the left, JavaScript on the right

### Hello World
```
print("hello world")                                console.log("hello world");
```

### Variable Declarations
```
make foo = 69                                       var foo = 69;
make bar:string = 69                                var bar = "69";
```

### Function Declarations
```
make adder = (a:int, b=10):int does deeg a + b      var adder = function (a, b) {
                                                        return a + b;
                                                    }

make even_and_true = (x:int, f():bool) does         var even_and_true = function (x, f) {
    if (f(x)) then                                      if (f(x)) {
        deeg x + 2                                          return x + 2;
    else                                                } else {
        deeg x + 4                                          return x + 4;
    end                                                 }
                                                    }
```

### Fibonacci Function example

```
make fibonacci = (x:int) does                       function fibonacci(x) {
    make a:int = 0, b:int = 1, c:int                    var a = 0, b = 1, c;
    if (x < 3) deeg 1                                   if (x < 3) return 1;
    while(--x)                                          while (--n)
        c = a + b, a = b, b = c                             c = a + b, a = b, b = c;
    deeg c                                              return c;
                                                    }

```

### GCD Function example
```
make gcd = (a:int, b:int):int does                  var gcd = function(a, b) {
    if (!b) exists                                      if ( ! b) {
        deeg a                                              return a;
    deeg gcd(b, a % b)                                  }
                                                        return gcd(b, a % b);
                                                    };
```
[deeg-img]: https://i.imgur.com/ylMlnSA.png
[deeg-url]: https://github.com/SirSeim/Deeg

[travis-img]: https://travis-ci.org/SirSeim/Deeg.svg?branch=master
[travis-url]: https://travis-ci.org/SirSeim/Deeg?branch=master

[codecov-img]: https://codecov.io/github/SirSeim/Deeg/coverage.svg?branch=master
[codecov-url]: https://codecov.io/github/SirSeim/Deeg?branch=master

[dependency-img]:https://img.shields.io/david/SirSeim/Deeg/master.svg
[dependency-url]:https://david-dm.org/SirSeim/Deeg

[dev-dependency-img]:https://img.shields.io/david/dev/SirSeim/Deeg/master.svg
[dev-dependency-url]:https://david-dm.org/SirSeim/Deeg#info=devDependencies
