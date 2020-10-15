local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'Question',
  id: 'age-last-birthday',
  page_title: 'Age last birthday',
  question: {
    id: 'age-last-birthday-question',
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
        validation: {
          messages: {
            NUMBER_TOO_LARGE: 'Enter an age less than or equal to %(max)s years',
          },
        },
      },
      {
        id: 'age-estimate-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'This age is an estimate',
            value: 'This age is an estimate',
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
