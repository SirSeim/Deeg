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
      kind: 'make',
      lexeme: 'make',
      line: 2,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 'z',
      line: 2,
      col: 6
    },
    {
      kind: '=',
      lexeme: '=',
      line: 2,
      col: 8
    },
    {
      kind: 'intlit',
      lexeme: '5',
      line: 2,
      col: 10
    },
    {
      kind: 'if',
      lexeme: 'if',
      line: 3,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 'x',
      line: 3,
      col: 4
    },
    {
      kind: '==',
      lexeme:  '==',
      line: 3,
      col: 5
    },
    {
      kind: 'intlit',
      lexeme: '5',
      line: 3,
      col: 7
    },
    {
      kind: 'and',
      lexeme: 'and',
      line: 3,
      col: 9
    },
    {
      kind: 'id',
      lexeme: 'z',
      line: 3,
      col: 13
    },
    {
      kind: '==',
      lexeme:  '==',
      line: 3,
      col: 14
    },
    {
      kind: 'intlit',
      lexeme:  '5',
      line: 3,
      col: 16
    },
    {
      kind: 'then',
      lexeme: 'then',
      line: 3,
      col: 18
    },
    {
      kind: 'deeg',
      lexeme: 'deeg',
      line: 4,
      col: 5
    },
    {
      kind: 'true',
      lexeme: 'true',
      line: 4,
      col: 10
    },
    {
      kind: 'else',
      lexeme: 'else',
      line: 5,
      col: 1
    },
    {
      kind: 'if',
      lexeme: 'if',
      line: 5,
      col: 6
    },
    {
      kind: 'id',
      lexeme: 'x',
      line: 5,
      col: 9
    },
    {
      kind: '!=',
      lexeme: '!=',
      line: 5,
      col: 11
    },
    {
      kind: 'intlit',
      lexeme:  '5',
      line: 5,
      col: 14
    },
    {
      kind: 'and',
      lexeme:  'and',
      line: 5,
      col: 16
    },
    {
      kind: 'id',
      lexeme: 'z',
      line: 5,
      col: 20
    },
    {
      kind: '!=',
      lexeme: '!=',
      line: 5,
      col: 22
    },
    {
      kind: 'intlit',
      lexeme:  '6',
      line: 5,
      col: 25
    },
    {
      kind: 'then',
      lexeme:  'then',
      line: 5,
      col: 27
    },
    {
      kind: 'deeg',
      lexeme: 'deeg',
      line: 6,
      col: 5
    },
    {
      kind: 'false',
      lexeme: 'false',
      line: 6,
      col: 10
    },
    {
      kind: 'EOF',
      lexeme: 'EOF'
    }
  ]
  program6: [
    {
      kind: 'make',
      lexeme: 'make',
      line: 1,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 'num',
      line: 1,
      col: 6
    },
    {
      kind: 'id',
      lexeme: 'num',
      line: 1,
      col: 6
    },
    {
      kind: '=',
      lexeme: '=',
      line: 1,
      col: 10
    },
    {
      kind: 'floatlit',
      lexeme: '5.422',
      line: 1,
      col: 12
    },
    {
      kind: 'make',
      lexeme: 'make',
      line: 2,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 'string',
      line: 2,
      col: 6
    },
    {
      kind: '=',
      lexeme: '=',
      line: 2,
      col: 13
    },
    {
      kind: 'strlit',
      lexeme: [
        '61',
        '62',
        '63',
        '20'
        ],
      line: 2,
      col: 15
    },
    {
      kind: '+',
      lexeme: '+',
      line: 2,
      col: 22
    },
    {
      kind: '(',
      lexeme: '(',
      line: 2,
      col: 22
    },
    {
      kind: 'id',
      lexeme: 'num',
      line: 2,
      col: 23
    },
    {
      kind: ')',
      lexeme: ')',
      line: 2,
      col: 26
    },
    {
      kind: '+',
      lexeme: '+',
      line: 2,
      col: 26
    },
    {
      kind: 'strlit',
      lexeme: [
        '61',
        '62',
        '63'
        ],
      line: 2,
      col: 27
    },
    {
      kind: 'make',
      lexeme: 'make',
      line: 3,
      col: 1
    },
    {
      kind: 'id',
      lexeme: 'y',
      line: 3,
      col: 6
    },
    {
      kind: '=',
      lexeme: '=',
      line: 3
      col: 8
    },
    {
      kind: 'strlit',
      lexeme: [],
      line: 3,
      col: 10
    },
    {
      kind: '+',
      lexeme: '+',
      line: 3,
      col: 12
    },
    {
      kind: '(',
      lexeme: '(',
      line: 3,
      col: 12
    },
    {
      kind: 'id',
      lexeme: 'num',
      line: 3,
      col: 13
    },
    {
      kind: ')',
      lexeme: ')',
      line: 3,
      col: 16
    },
    {
      kind: '+',
      lexeme: '+',
      line: 3,
      col: 16
    },
    {
      kind: 'strlit',
      lexeme: [],
      line: 3,
      col: 17
    },
    {
      kind: 'EOF',
      lexeme: 'EOF'
    }
  ]
}
