[![Deeg Logo](http://i.imgur.com/ylMlnSA.png)](https://github.com/IrakliK/Deeg)
#Deeg

##Introduction
Deeg is a static, object-oriented, strongly-typed language that has powerful and efficient features, including type inferencing, list comprehensions, optionals, string interpolation and first class functions. Deeg compiles nicely into JavaScript. Deeg is the future, and if you don't think so, then you are living in the past, buddy.

##List of Features

- ~~Object oriented~~
- First class functions
- Optional parameters/default parameters
- Indentation instead of curly braces
- Parenthesis are optional, except for functions
- Optionals
- .deeg file extension
- String Interpolation
- Type Inference
- make usage
- Specify type with :
- Optional type specify with ?
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
}
```

####Type Inference and Static Typing

Heirachy of types:

bool -> int -> float -> string -> List -> Dict

This heirachy is what determines auto conversions. A type can be upconverted automatically if needed. If you want to convert down the tree, then you need to specify it with a type converter function like `int()` or 'float()'. Some conversions may return optionals if conversion cannot be guaranteed


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

###Ranges and Slices for Iterables

```
not discussed
```

###If Statements

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

###For and While Loops

```
for cat in cat_array then
    print("mr. " + cat)
end

for count int_expression then
    print("hello")
end

for i counts int_expression then
    print(i + " hello(s)")
end

while is_running then
    runFaster()
end
```

###Functions

```
make add_pizazz = (bore:string) does
    deeg bore + "!"

make f = (a, b):Function does
    deeg (a, b) = deeg a + b

make deeginator = (x, y:float):bool does
    make isAwesome = (x - y * 2 == 69)
    deeg isAwesome
```

###Optionals
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

###Arrays/Lists and Dictionaries

```
make array = ["Hello", "Goodbye"]
make dict = { name to "Bob", age:int to 35, isPresident to false}

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
make dict = array + {}                  # convert array to dict
make dict1 = array:Dict                 # convert array to dict
make dict2:Dict = array                 # convert array to dict
make arr = map(array_str, (a) does deeg a:float)

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

##Example Programs

Deeg on the left, JavaScript on the right

###Hello World
```
print("hello world")                                console.log("hello world");
```

###Variable Declarations
```
make foo = 69                                       var foo = 69;
make bar:string = 69                                var bar = "69";
```

###Function Declarations
```
make adder = (a:int, b=10):int does deeg a + b      var adder = function (a, b) {
                                                     
                                                    }

make even_and_true = (x:int, f():bool) does         var even_and_true = function (x, f) {
    if (f(x)) then                                      if (f(x)) {
        deeg x + 2                                          return x + 2
    else                                                } else {
        deeg x + 4                                          return x + 4
    end                                                 }
                                                    }
```
