#### Comments:

    #comment yes

    ###
    multi-line/block comment
    ###

    ### also valid block comment ###

#### ~~Object Construction:~~

_Still deciding if we want java like objects_

<!-- ## ~~Option 1:  value is a keyword referring to construction argument when only have 1~~
                if value is in the constructor, then the object requires one arg
                can set the type of value
                keyword of gives inheritance
                keyword form is like class
                keyword constr is the constructor
                keyword get is equivalent to return 
                head and next are local fields
                head:double is declaring the type of head
                ?= means if value is not defined, head will be set to nil

    form Node ->

        constr ->
            head:double ?= value
            next:Node = Node n

        Get ->
            get head

        Set argument->
            value = argument



        form Tree of Node ->

            constr ->
                head = value:Node

        Main ->

            n:Node = Node 14
            t = Tree n
            t.Set 3
            t.Get

## ~~Option 2:~~

    class Node argument:

        Node:
            head = argument

        Get_head:
            return head

        Set_head argument:
            head = argument

    class Binary_tree of Node argument<Node>:

        Binary_tree:
            head = argument
            left = new Tree l
            right = new Tree r
        
    Main:

    n1<Node> = new Node 3
    n2 = new Node 14
    b_t = new Binary_tree n2
    n.Set_head 15
    n.Get

## ~~Option 3:~~
    
    form Node:
        
        constr:
            head:double ?= value
            next:Node = Node n

        Get:
            get head

        Set argument:
            value = argument

        form Tree of Node:
            constr:
                head = value:Node

        Main:
            n:Node = Node 14
            t = Tree n
            t.Set 3
            t.Get -->

#### Arrays and Dictionaries

    make array = ["Hello", "Goodbye"]
    make dict = { name to "Bob", age:int to 35, isPresident to false}

    print(array[0])                     # prints "Hello"
    print(array[2])                     # maybe array[2] returns an optional, else this errors

    make combo = array + dict           # combo is an object with keys 0 and 1

    print(dict.size())                  # prints 3
    print(array.size())                 # prints 2
    print(combo.size())                 # prints 5

    make error_dict = { size to 3 }     # error, size is reserved in dictionaries

    make array_multi = array * 2        # array_multi is ["Hello", "Goodbye", "Hello", "Goodbye", "Hello", "Goodbye"]

    make array_combine = array + ["Hi"] # array_combine is ["Hello", "Goodbye", "Hi"]
    
    make array_str = array + "Hi"       # array_str is ["Hello", "Goodbye", "Hi"]

    make int_array:int = [2, 3]         # arrays are homogeneous
    make all_dict = {                   # dictionaries are heterogeneous
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

#### Optionals

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

    make str = array[i] if i exists else "not found"

#### Conditionals
    if bool_expression then
        # perform action
    else
        # other action


    if bool_expression then
        # action
    else if bool_expression then
        # other conditional action
    else
        # if nothing else

    if bool_expression then ###action### else ###if nothing else###

    make interesting_result = "happy times" if bool_expression else "sad times"


#### Functions

    make add(x,y) = deeg x + y

    ###
    equivalent to
    make add:(x:int, y:int):int = deeg x + y
    ():denotes return type of function
    ###

maybe have it as follows:

    make add:Function(x:int, y:int):int = deeg x + y

type declaration not required, type inference used

    make complex(a:string) =
        make add_it = a * 3
        deeg (str) = deeg str + add_it
    make fun = complex("hi")
    print(fun("world"))         # "hihihiworld"

#### Random Statements:

    for(i <= limit,1):
        do stuff

    for(i<double> <= limit,0.5):
        do stuff
    
    for(i::double <= limit, 1):
        do things

    for x in [1,2,3,4], x -> x * 2

    for [1,2,3,4] -> value * 2 # value refers to the pointer

    [1,2,3] + [4] = [1,2,3,4]
    [1,2,3] + 4 = [1,2,3,4]
    4 + [1,2,3] = [4,1,2,3] # if find an array in evaluation, change path to array addition
                            # this will be very hard lol

    1 + 2 + [3,4] + 5 = [1,2,3,4,5] // will translate to [1] + [2] + [3,4] + [5]

    if true then dothing1,dothing2,dothing3 else dothing4
    if boolean1:
        dothing1
        dothing2
    elif boolean2:
        dothing3
    else:
        dothing4


    if boolean1 -> dothing1,dothing2 else -> dothing3 # I dont think we should use arrows - eko
    if boolean1 ->
        dothing1
        dothing2
    else ->
        dothing3

    limit:int = 5 # Like this better - eko 
    count:int = 0
    while limit ->
        limit -= 1
        count += 1

    limit<int> = 5 # Don't like < > - eko
    count<int> = 0
    while limit:
        limit -= 1
        count += 1


    make s:string = "world"
    make s = "world"
    "hello " + s                # option 1 could be in addition to string interpolation
    "hello {s}"                 # option 2
    "hello \{s}"                # option 3

    let x = 2 in
        foo(x)

    make y = 2                  # type inferred is int      make y:int = 2
    make z = 2.0                # type inferred is float    make z:float = 2.0
    make y_plus_z = y + z       # type inferred is double   make y_plus_z:float = y + z

    make a:string = "dup" * 3  # "dupdupdup"
    make b = "dup" + "licate"   # "duplicate"
    
    make c = 4 * "dup"          # "dupdupdupdup"
    make d = "5" * "2"          # how strong is our type inferencing
    make e:int = "5" * "2"     # error or let it go as 10?
    
