local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'place-of-work-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'place-of-work-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No, it is in the Republic of Ireland',
          value: 'No, it is in the Republic of Ireland',
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
  id: 'place-of-work',
  question_variants: [
    {
      question: question('Is your main place of work in Northern Ireland?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'Is <em>{person_name_possessive}</em> main place of work in Northern Ireland?',
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
        block: 'place-of-work-elsewhere',
        when: [
          {
            id: 'place-of-work-answer',
            condition: 'equals',
            value: 'No, it is in another country',
          },
        ],
      },
    },
    {
      goto: {
        block: 'work-location',
      },
    },
  ],
}
