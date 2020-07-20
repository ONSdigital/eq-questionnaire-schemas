local placeholders = import '../../../lib/placeholders.libsonnet';

{
  id: 'primary-person-list-collector',
  type: 'PrimaryPersonListCollector',
  for_list: 'household',
  add_or_edit_answer: {
    id: 'you-live-here-answer',
    value: 'Yes',
  },
  add_or_edit_block: {
    id: 'add-or-edit-primary-person',
    type: 'PrimaryPersonListAddOrEditQuestion',
    question: {
      id: 'primary-person-add-or-edit-question',
      type: 'General',
      title: 'What is your full name?',
      answers: [
        {
          id: 'first-name',
          label: 'First name',
          mandatory: true,
          type: 'TextField',
        },
        {
          id: 'middle-names',
          label: 'Middle names',
          mandatory: false,
          type: 'TextField',
        },
        {
          id: 'last-name',
          label: 'Last name',
          mandatory: true,
          type: 'TextField',
        },
      ],
    },
  },
  question: {
    id: 'primary-confirmation-question',
    type: 'General',
    title: {
      text: 'Were you usually living at {household_address} on Sunday {census_date}?',
      placeholders: [
        placeholders.address,
        placeholders.censusDate,
      ],
    },
    instruction: [
        'Tell the respondent to turn to <strong>Showcard 1</strong> or show them the <strong>Electronic Showcard</strong> below'
    ],
    definitions: [
      {
        title: 'Electronic Showcard',
        contents: [
          {
            title: '“Usually living at” means:',
          },
          {
            description: 'The address at which you generally spend most time, for most people this will be their permanent or family home.',
          },
          {
            list: [
              '<strong>full-time students</strong> should include themselves here',
              '<strong>armed forces members</strong> should include themselves at their home address if they have one',
              '<strong>include anyone temporarily outside the UK, if this was for less than 12 months</strong>',
            ],
          },
        ],
      },
    ],
    answers: [
      {
        id: 'you-live-here-answer',
        mandatory: true,
        type: 'Radio',
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
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        block: 'anyone-else-usually-living',
        when: [
          {
            id: 'you-live-here-answer',
            condition: 'equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        block: 'anyone-else-list-collector',
      },
    },
  ],
}
