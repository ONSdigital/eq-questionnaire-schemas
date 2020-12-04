{
  type: 'Question',
  id: 'anyone-related',
  skip_conditions: [
    {
      when: [
        {
          list: 'household',
          condition: 'less than',
          value: 2,
        },
      ],
    },
  ],
  question: {
    id: 'anyone-related-question',
    title: 'Are any of these people related to each other?',
    description: [
      'Remember to include partners and stepchildren as related',
    ],
    type: 'General',
    answers: [{
      id: 'anyone-related-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No, all household members are unrelated',
          value: 'No, all household members are unrelated',
        },
      ],
      type: 'Radio',
    }],
  },
  list_summary: {
    for_list: 'household',
    summary: {
      item_title: {
        text: '{person_name}',
        placeholders: [
          {
            placeholder: 'person_name',
            transforms: [
              {
                arguments: {
                  delimiter: ' ',
                  list_to_concatenate: {
                    identifier: ['first-name', 'last-name'],
                    source: 'answers',
                  },
                },
                transform: 'concatenate_list',
              },
            ],
          },
        ],
      },
    },
  },
}
