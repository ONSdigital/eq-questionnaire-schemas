local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'ListCollectorDrivingQuestion',
  for_list: 'visitors',
  id: 'any-visitors',
  question: {
    type: 'General',
    id: 'any-visitors-question',
    title: {
      text: 'How many visitors were staying overnight at {household_address} on Sunday {census_date}?',
      placeholders: [
        placeholders.address,
        placeholders.censusDate,
      ],
    },
    description: 'A visitor is a person staying overnight who usually lives at another address',
    instruction: 'Tell the respondent to turn to <strong>Showcard 13</strong> or show them the Electronic Showcard below',
    definitions: [
      {
        title: 'Electronic Showcard',
        contents: [
          {
            description: 'Include',
          },
          {
            list: [
              'people who usually lived somewhere else in the UK, for example, boyfriends, girlfriends, friends or relatives',
              'people staying because it was their second address, for example, for work - their permanent or family home was elsewhere',
              'people who usually lived outside the UK who were staying in the UK for <strong>less than 3 months</strong>',
              'people staying on holiday',
            ],
          },
          {
            description: 'Or',
          },
          {
            list: [
              {
                text: 'there were no visitors staying overnight on {census_date}',
                placeholders: [
                  placeholders.censusDate,
                ],
              },
            ],
          },
        ],
      },
    ],
    answers: [
      {
        id: 'any-visitors-answer',
        mandatory: true,
        options: [
          {
            label: '1 or more',
            value: '1 or more',
            action: {
              type: 'RedirectToListAddQuestion',
              params: {
                block_id: 'add-visitor',
                list_name: 'visitors',
              },
            },
          },
          {
            label: 'None',
            value: 'None',
          },
        ],
        type: 'Radio',
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        section: 'End',
        when: [{
          id: 'any-visitors-answer',
          condition: 'equals',
          value: 'None',
        }],
      },
    },
    {
      goto: {
        block: 'visitor-list-collector',
      },
    },
  ],
}
