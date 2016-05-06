module.exports = {
  program1: '''(function () {
    (function () {
      var _v1 = 5;
      var _v2 = 45;
      return (function () {
        if ( ( _v1 >= 3 ) ) {
          return (function () {
            return console.log( "A is big" );
          }());
        } else if ( ( _v2 <= 45 ) ) {
          return (function () {
            return console.log( "B is small" );
          }());
        } else {
          return (function () {
            return console.log( "False!" );
          }());
        }
      }());
    }());
  }());''',

  program2: '''(function () {
      return console.log("Hello, World!")
    }())'''
}
