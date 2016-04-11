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
  ],
  program4: [
    {
      kind: 'intlit',
      lexeme: '5',
      line: 1,
      col: 1
    },
    {
      kind: '==',
      lexeme: '==',
      line: 1,
      col: 3
    },
    {
      kind: 'intlit',
      lexeme: '6',
      line: 1,
      col: 6
    },
    {
      kind: 'intlit',
      lexeme: '1',
      line: 2,
      col: 1
    },
    {
      kind: '!=',
      lexeme: '!=',
      line: 2,
      col: 3
    },
    {
      kind: 'intlit',
      lexeme: '3',
      line: 2,
      col: 6
    },
    {
      kind: 'intlit',
      lexeme: '1',
      line: 3,
      col: 1
    },
    {
      kind: '<',
      lexeme: '<',
      line: 3,
      col: 3
    },
    {
      kind: 'intlit',
      lexeme: '2',
      line: 3,
      col: 5
    },
    {
      kind: 'true',
      lexeme: 'true',
      line: 4,
      col: 1
    },
    {
      kind: 'and',
      lexeme: 'and',
      line: 4,
      col: 6
    },
    {
      kind: 'false',
      lexeme: 'false',
      line: 4,
      col: 10
    },
    {
      kind: 'intlit',
      lexeme: '5',
      line: 5,
      col: 1
    },
    {
      kind: '-',
      lexeme: '-',
      line: 5,
      col: 3
    },
    {
      kind: 'intlit',
      lexeme: '3',
      line: 5,
      col: 5
    },
    {
      kind: '-',
      lexeme: '-',
      line: 6,
      col: 1
    },
    {
      kind: 'intlit',
      lexeme: '1',
      line: 6,
      col: 2
    },
    {
      kind: '>',
      lexeme: '>',
      line: 6,
      col: 4
    },
    {
      kind: '-',
      lexeme: '-',
      line: 6,
      col: 6
    },
    {
      kind: 'intlit',
      lexeme: '5',
      line: 6,
      col: 7
    },
    {
      kind: 'strlit',
      lexeme: [
        '73',
        '74',
        '72'
      ],
      line: 7,
      col: 1
    },
    {
      kind: '*',
      lexeme: '*',
      line: 7,
      col: 7
    },
    {
      kind: 'intlit',
      lexeme: '3',
      line: 7,
      col: 9
    }
    {
      kind: 'make',
      lexeme: 'make',
      line: 8,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 'str',
      line: 8,
      col: 6
    },
    {
      kind: 'type',
      lexeme: 'string',
      line: 8,
      col: 9
    },
    {
      kind: '=',
      lexeme: '=',
      line: 8,
      col: 17
    },
    {
      kind: 'strlit',
      lexeme: [
        '48',
        '69',
      ],
      line: 8,
      col: 19
    },
    {
      kind: 'make',
      lexeme: 'make',
      line: 9,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 'isEql',
      line: 9,
      col: 6
    },
    {
      kind: '=',
      lexeme: '=',
      line: 9,
      col: 12
    },
    {
      kind: 'id',
      lexeme: 'x',
      line: 9,
      col: 14
    },
    {
      kind: '==',
      lexeme: '==',
      line: 9,
      col: 16
    },
    {
      kind: 'intlit',
      lexeme: '6',
      line: 9,
      col: 19
    },
    {
      kind: 'EOF',
      lexeme: 'EOF'
    }
  ]
  program5: [
    {
      kind: 'make',
      lexeme: 'make',
      line: 1,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 'x',
      line: 1,
      col: 7
    },
    {
      kind: '=',
      lexeme: '=',
      line: 1,
      col: 9
    },
    {
      kind: 'intlit',
      lexeme: '5',
      line: 1,
      col: 11
    },
    {
      kind: 'make',
      lexeme: 'make',
      line: 2,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 'z',
      line: 2,
      col: 7
    },
    {
      kind: '=',
      lexeme: '=',
      line: 2,
      col: 9
    },
    {
      kind: 'intlit',
      lexeme: '5',
      line: 1,
      col: 11
    },
  ]
}
