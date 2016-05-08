module.exports = {
  program1: '''(function () {
    var _v1 = 5;

    var _v2 = 45;

    if (( test >= 3 )) {
    print("A is big")

    } else if (( test <= 45 )) {
    print("B is small")

    } else {
    print("False!")

    }

    }());''',

  program2: '''(function () {
    print("Hello, World!")
    }());''',

  program3: '''(function () {
    var _v1 = function (_v2) {
    print(_v2)
    }
    
    _v1("fail")
    }());'''
}
