local placeholders = import '../../../lib/placeholders.libsonnet';

{
  id: 'were-you-usually-living-here',
  type: 'PrimaryPersonListCollector',
  for_list: 'household',
  add_or_edit_block: {
    id: 'what-is-your-name',
    type: 'PrimaryPersonListAddOrEditQuestion',
    question: {
      id: 'what-is-your-name-question',
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
      'Tell the respondent to turn to <strong>Showcard 1</strong> or show them the <strong>Electronic Showcard</strong> below',
    ],
    definitions: [
      {
        title: 'Electronic Showcard',
        contents: [
          {
            title: '“Usually living at” means:',
          },
          {
            description: 'The address at which you generally spend most time. For most people this will be their permanent or family home.',
          },
          {
            list: [
              '<strong>Full-time students</strong> should include themselves here.',
              '<strong>Armed forces members</strong> should include themselves at their home address if they have one.',
              'Include <strong>anyone temporarily outside the UK</strong>, if this was for less than 12 months.',
            ],
          },
        ],
      },
    ],
    answers: [
      {
        id: 'were-you-usually-living-here-answer',
        mandatory: true,
        type: 'Radio',
        options: [
          {
            label: 'Yes',
            value: 'Yes',
            action: {
              type: 'RedirectToAddOrEditBlock',
            },
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
        block: 'anyone-else-usually-living-here',
        when: [
          {
            id: 'were-you-usually-living-here-answer',
            condition: 'equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        block: 'who-else-lives-here',
      },
    },
  ],
}
