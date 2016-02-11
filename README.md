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
```

###Primitive Types & Reference Types
We have three primitive types: `int` `float` `bool` `string` and however many reference types: `dict`

####Type Inference and Static Typing

```
make year = 99                     # Inferred int
make fraction = 2.5                # Inferred float
make is_finished = true            # Inferred bool

make grade:float = 95              # Forced to be 95.0
make number_of_people:string = 56  # Forced to be "56"

make mapping:dict = {
    key to "value",
    key2 to 91
}
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
