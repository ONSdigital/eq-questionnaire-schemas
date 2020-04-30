{
  type: 'Question',
  id: 'term-time-address-country',
  question: {
    id: 'term-time-address-country-question',
    title: 'Is this address in the UK?',
    type: 'General',
    answers: [
      {
        id: 'term-time-address-country-answer',
        mandatory: false,
        options: [
          {
            label: 'Yes',
            value: 'Yes',
          },
          {
            label: 'No',
            value: 'No',
          },
        ],
        type: 'Radio',
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        block: 'term-time-address-details',
        when: [
          {
            id: 'term-time-address-country-answer',
            condition: 'equals',
            value: 'Yes',
          },
        ],
      },
    },
    {
      goto: {
        block: 'term-time-address-country-outside-uk',
        when: [
          {
            id: 'term-time-address-country-answer',
            condition: 'equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        section: 'End',
      },
    },
  ],
}
