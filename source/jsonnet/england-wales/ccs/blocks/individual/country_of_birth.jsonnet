local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'country-of-birth-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'country-of-birth-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No, born outside the UK',
          value: 'No, born outside the UK',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Were you born in the UK?';
local proxyTitle = {
  text: 'Was <em>{person_name}</em> born in the UK?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'country-of-birth',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'marital-or-civil-partnership-status',
        when: [
          rules.over15,
        ],
      },
    },
    {
      goto: {
        block: 'marital-or-civil-partnership-status',
        when: [
          rules.estimatedAge,
        ],
      },
    },
    {
      goto: {
        block: 'ethnic-group',
      },
    },
  ],
}
