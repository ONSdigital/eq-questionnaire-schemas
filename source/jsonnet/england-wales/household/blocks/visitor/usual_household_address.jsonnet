local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';


{
  type: 'Question',
  id: 'usual-household-address',
  question: {
    id: 'usual-address-household-question',
    title: {
      text: 'What is <em>{person_name_possessive}</em> usual address?',
      placeholders: [
        placeholders.personNamePossessive,
      ],
    },
    type: 'General',
    answers: [
      {
        guidance: {
          show_guidance: 'Why we ask for visitor details',
          hide_guidance: 'Why we ask for visitor details',
          contents: [
            {
              description: 'Your answer helps to ensure that everyone is counted in the census. Add visitor details, even if you think they have been included on a census questionnaire at another address.',
            },
          ],
        },
        id: 'usual-address-household-answer',
        mandatory: false,
        options: [
          {
            label: 'An address in the UK',
            value: 'An address in the UK',
          },
          {
            label: 'An address outside the UK',
            value: 'An address outside the UK',
            description: 'You can enter their country on the next question',
          },
        ],
        type: 'Radio',
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        block: 'usual-address-details',
        when: [
          {
            id: 'usual-address-household-answer',
            condition: 'equals',
            value: 'An address in the UK',
          },
        ],
      },
    },
    {
      goto: {
        block: 'usual-household-address-other',
        when: [
          {
            id: 'usual-address-household-answer',
            condition: 'equals',
            value: 'An address outside the UK',
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
