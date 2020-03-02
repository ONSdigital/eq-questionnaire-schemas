{
  type: 'Question',
  id: 'number-of-vehicles',
  question: {
    id: 'number-of-vehicles-question',
    title: 'In total, how many cars or vans are owned, or available for use, by members of this household?',
    type: 'General',
    guidance: {
      contents: [{
        title: 'Include any company cars or vans available for private use.',
      }],
    },
    answers: [{
      id: 'number-of-vehicles-answer',
      mandatory: false,
      options: [
        {
          label: 'None',
          value: 'None',
        },
        {
          label: '1',
          value: '1',
        },
        {
          label: '2',
          value: '2',
        },
        {
          label: '3',
          value: '3',
        },
        {
          label: '4',
          value: '4',
        },
        {
          label: '5 or more',
          value: '5 or more',
          description: 'Select to enter number',
          detail_answer: {
            id: 'number-of-vehicles-answer-other',
            type: 'Number',
            mandatory: false,
            label: 'Enter the number of cars or vans',
            maximum: {
              value: 20,
            },
          },
        },
      ],
      type: 'Radio',
    }],
  },
}
