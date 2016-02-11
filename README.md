[![Deeg Logo](http://i.imgur.com/ylMlnSA.png)](https://github.com/IrakliK/Deeg)
#Deeg

##Introduction
Deeg is a static, object-oriented, strongly-typed language that has powerful and efficient features, including type inferencing, list comprehensions, optionals, string interpolation and first class functions. Deeg compiles nicely into JavaScript. Deeg is the future, and if you don't think so, then you are living in the past, buddy.

##List of Features

- Object oriented
- First class functions
- Optional parameters/default parameters
- Indentation instead of curly braces
- Parenthesis are optional
- Optionals
- .deeg file extension
- String Interpolation
- Type Inference
- make usage
- Specify type with :
- Optional type specify with ?
- let <expression> in <body>
- List Comprehensions

##Features

###Comments

```
# commented to the end of line
### multi-line comment
    comments
    comments
###
```

###Assignments

```
make example_variable = "this string"
make example_variable2 = 200

make a = 4
make b = 8
a, b = b, a

make c, d = 2, 16
```

###Primitive Types & Reference Types
We have four primitive types: `int` `float` `bool` `string` and however many reference types: `Dict` `Function` `List`

####Type Inference and Static Typing

```
make year = 99                     # Inferred int
make fraction = 2.5                # Inferred float
make is_finished = true            # Inferred bool

make grade:float = 95              # Forced to be 95.0
make number_of_people:string = 56  # Forced to be "56"

make mapping:dict = {
    key to "value",
    key2 to 91,
    funKey to (x, y) = x * y;,
    funKey2 to (a, b) =
        deeg a + b
}
```

###Ranges and Slices for Iterables

###If Statements

```
if (is_correct) then print "CORRECT!" end

if (is_wrong) then
    print "WRONGO-BONGO!"
else
    print "good job, sport"

if (is_zebra) then
    print "you are a zebra"
else if (is_tiger) then
    print "you are a tiger"
else
    print "you aren't a tiger or a zebra"
```

###For Loops

###While Loops

###Functions

make add_pizazz(bore:String) =
    deeg bore + "!"

make f(a, b):Function =
    deeg (a, b) = deeg a + b

###Optionals
Optionals are not the default type for variables.

```
make toys = ["bear"]
make unicorn:? = toys.indexOf("unicorn")

if unicorn exists
    print unicorn
else
    print "dreams crushed"
```

##Example Programs

Deeg on the left, JavaScript on the right

###Hello World
```
print "hello world"                                            console.log("hello world");
```

###Variable Declarations
```
make foo = 69                                                  var foo = 69;
make bar:string = 69                                           var bar = "69";
```

###Function Declarations
```
make adder(a:int, b = 10):int = deeg a + b

make even_and_true(x:int, f():bool) =
    if (f(x)) then
        deeg x + 2
    else
        deeg x + 4
```
