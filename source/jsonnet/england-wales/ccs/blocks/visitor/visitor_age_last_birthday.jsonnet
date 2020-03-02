local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'Question',
  id: 'visitor-age-last-birthday',
  question: {
    id: 'visitor-age-last-birthday-question',
    description: '',
    type: 'General',
    title: {
      text: 'What was {person_name_possessive} age on their last birthday?',
      placeholders: [placeholders.personNamePossessive],
    },
    answers: [
      {
        id: 'visitor-age-last-birthday-answer',
        label: 'Age',
        mandatory: false,
        type: 'Number',
        minimum: {
          value: 0,
        },
        maximum: {
          value: 115,
        },
      },
      {
        id: 'visitor-age-estimate-answer',
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
        block: 'visitor-sex',
      },
    },
  ],
}
