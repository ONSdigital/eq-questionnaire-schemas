local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'study-location-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'study-location-answer',
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
  id: 'study-location',
  page_title: 'Study location',
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
        block: 'study-location-country',
        when: [
          {
            id: 'study-location-answer',
            condition: 'equals',
            value: 'No, it is in another country',
          },
        ],
      },
    },
    {
      goto: {
        block: 'study-location-in-northern-ireland',
      },
    },
  ],
}
