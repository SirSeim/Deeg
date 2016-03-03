module.exports = {
  program1: [
    {
      kind: 'EOF',
      lexeme: 'EOF'
    }
  ],
  program2: [
    {
      kind: 'make',
      lexeme: 'make',
      line: 1,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 's',
      line: 1,
      col: 6
    },
    {
      kind: '=',
      lexeme: '=',
      line: 1,
      col: 8
    },
    {
      kind: 'intlit',
      lexeme: '5',
      line: 1,
      col: 10
    },
    {
      kind: 'EOF',
      lexeme: 'EOF'
    }
  ],
  program3: [
    {
      kind: 'EOF',
      lexeme: 'EOF'
    }
  ]
}