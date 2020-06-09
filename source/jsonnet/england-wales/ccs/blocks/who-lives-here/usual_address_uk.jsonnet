local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'usual-address-uk',
  question: {
    id: 'usual-address-uk-question',
    title: {
      text: 'On Sunday {census_date}, was your usual address in the UK?',
      placeholders: [
        placeholders.censusDate,
      ],
    },
    type: 'General',
    answers: [{
      id: 'usual-address-uk-answer',
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
            id: 'usual-address-uk-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter current name of country',
            visible: true,
          },
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
      goto: {
        block: 'outside-uk-interstitial',
        when: [
          {
            id: 'usual-address-uk-answer',
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
