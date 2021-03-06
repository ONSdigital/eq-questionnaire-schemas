local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'usual-address-in-uk',
  question: {
    id: 'usual-address-in-uk-question',
    description: [
      '“Usual address” means the address at which you generally spend most time, for most people this will be their permanent or family home',
    ],
    title: {
      text: 'On Sunday {census_date}, was your usual address in the UK?',
      placeholders: [
        placeholders.censusDate,
      ],
    },
    type: 'General',
    answers: [{
      id: 'usual-address-in-uk-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No',
          value: 'No',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'usual-address-in-uk-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter current name of country',
          },
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
      goto: {
        block: 'outside-uk-note',
        when: [
          {
            id: 'usual-address-in-uk-answer',
            condition: 'equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        block: 'usual-address',
      },
    },
  ],
}
