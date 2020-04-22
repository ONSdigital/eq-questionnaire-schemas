local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'Question',
  id: 'age-last-birthday',
  question: {
    id: 'age-last-birthday-question',
    description: '',
    type: 'General',
    title: {
        text: 'What was <em>{person_name_possessive}</em> age on their last birthday?',
        placeholders: [
            placeholders.personNamePossessive,
        ],
    },
    answers: [
      {
        id: 'age-last-birthday-answer',
        label: 'Age',
        mandatory: true,
        type: 'Number',
        minimum: {
          value: 0,
        },
        maximum: {
          value: 115,
        },
      },
      {
        id: 'age-estimate-answer',
        label: '',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'Estimate',
            value: 'Estimate',
          },
        ],
      },

    ],
  },
  routing_rules: [
    {
      goto: {
        block: 'sex',
      },
    },
  ],
}
