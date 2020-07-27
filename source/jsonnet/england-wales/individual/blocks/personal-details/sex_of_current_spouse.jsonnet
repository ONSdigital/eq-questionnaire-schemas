local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'sex-of-current-spouse-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'sex-of-current-spouse-answer',
      mandatory: false,
      options: [
        {
          label: 'Someone of the opposite sex',
          value: 'Someone of the opposite sex',
        },
        {
          label: 'Someone of the same sex',
          value: 'Someone of the same sex',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Who is your legal marriage to?';
local proxyTitle = {
  text: 'Who is <em>{person_name_possessive}</em> legal marriage to?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'sex-of-current-spouse',
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
        block: 'another-address',
      },
    },
  ],
}
