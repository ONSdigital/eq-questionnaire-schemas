{
  type: 'Question',
  id: 'visitors-in-establishment',
  question: {
    id: 'visitors-in-establishment-question',
    title: 'Are any of the following visitors staying overnight in this establishment on 21 March 2021?',
    type: 'MutuallyExclusive',
    guidance: {
      contents: [{
        description: '<em>Include</em> shift workers, for example, care workers, hotel porters, who are staying overnight on 21 March 2021 as visitors',
      }],
    },
    mandatory: false,
    answers: [
      {
        id: 'visitors-in-establishment-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'Anyone with another usual address in the UK who has spent, or expects to spend, less than 6 months in this establishment',
            value: 'Anyone with another usual address in the UK who has spent, or expects to spend, less than 6 months in this establishment',
          },
          {
            label: 'Anyone from outside the UK who intends to stay in the UK for less than 3 months',
            value: 'Anyone from outside the UK who intends to stay in the UK for less than 3 months',
          },
        ],
      },
      {
        id: 'visitors-in-establishment-exclusive',
        type: 'Checkbox',
        mandatory: false,
        options: [
          {
            label: 'None of these apply',
            value: 'None of these apply',
          },
        ],
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        group: 'submit-group',
        when: [
          {
            id: 'visitors-in-establishment-exclusive',
            condition: 'set',
          },
        ],
      },
    },
    {
      goto: {
        block: 'number-of-visitors-in-establishment',
      },
    },
  ],
}
