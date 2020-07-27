local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'place-of-study-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'place-of-study-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No, it is in another country',
          value: 'No, it is in another country',
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'place-of-study',
  question_variants: [
    {
      question: question('Is your place of <em>study</em> in Northern Ireland?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'Is <em>{person_name_possessive}</em> place of <em>study</em> in Northern Ireland?',
        placeholders: [
          placeholders.personNamePossessive,
        ],
      }),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'place-of-study-elsewhere',
        when: [
          {
            id: 'place-of-study-answer',
            condition: 'equals',
            value: 'No, it is in another country',
          },
        ],
      },
    },
    {
      goto: {
        block: 'school-location',
      },
    },
  ],
}
