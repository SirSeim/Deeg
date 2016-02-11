#### Comments:

    #comment yes

    ###
    multi-line comment
    ###

#### Object Construction:

## Option 1:    value is a keyword referring to construction argument when only have 1
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

## Option 2:

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

## Option 3:
    
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
            t.Get


#### Random Statements:

    for(i <= limit,1):
        do stuff

    for(i<double> <= limit,0.5):
        do stuff
    
    for(i::double <= limit, 1):
        do things

    for x in [1,2,3,4], x -> x * 2

    for [1,2,3,4] -> value * 2 // value refers to the pointer

    [1,2,3] + [4] = [1,2,3,4]
    [1,2,3] + 4 = [1,2,3,4]
    4 + [1,2,3] = [4,1,2,3] // if find an array in evaluation, change path to array addition
                            // this will be very hard lol

    1 + 2 + [3,4] + 5 = [1,2,3,4,5] // will translate to [1] + [2] + [3,4] + [5]

    if true then dothing1,dothing2,dothing3 else dothing4
    if boolean1:
        dothing1
        dothing2
    elif boolean2:
        dothing3
    else:
        dothing4


    if boolean1 -> dothing1,dothing2 else -> dothing3 // I dont think we should use arrows - eko
    if boolean1 ->
        dothing1
        dothing2
    else ->
        dothing3

    limit:int = 5 // Like this better - eko 
    count:int = 0
    while limit ->
        limit -= 1
        count += 1

    limit<int> = 5 // Don't like < > - eko
    count<int> = 0
    while limit:
        limit -= 1
        count += 1


    make s:string = "world"
    make s::string = "world"
    make s<string> = "world"
    make s = "world"
    make string s = "world"
    "hello <s>"
    "hello " + s
    "hello {s}"
    "hello *s*"

    let x = 2 in
        foo(x)

    make y = 2 // type inferred is int
    make z = 2.0 // type inferred is double
    make y_plus_z = y + z // type inferred is double

    make a::string = "dup" * 3 // "dupdupdup"
    make b = "dup" + "licate" // "duplicate"
    
    make c = 4 * "dup" // syntax error or "dupdupdupdup"
    make d = "5" * "2" // how strong is our type inferencing
    make e::int = "5" * "2" // error or let it go as 10?
    
