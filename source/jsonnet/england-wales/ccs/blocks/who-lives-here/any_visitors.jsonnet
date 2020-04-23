local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'ListCollectorDrivingQuestion',
  for_list: 'visitors',
  id: 'any-visitors',
  question: {
    type: 'General',
    id: 'any-visitors-question',
    title: {
      text: 'How many visitors were staying in your household at {household_address} on {census_date}?',
      placeholders: [
        placeholders.address,
        placeholders.censusDate,
      ],
    },
    instruction: 'Tell respondent to turn to <strong>Showcard 13</strong>',
    guidance: {
      contents: [
        {
          description: 'A visitor is a person staying overnight in your household who usually lives at another address.',
        },
      ],
    },
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
