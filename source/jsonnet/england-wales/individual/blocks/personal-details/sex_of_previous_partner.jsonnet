local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'sex-of-previous-partner-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'sex-of-previous-partner-answer',
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

local nonProxyTitle = 'Who was your registered civil partnership to?';
local proxyTitle = {
  text: 'Who was <em>{person_name_possessive}</em> registered civil partnership to?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'sex-of-previous-partner',
  page_title: 'Sex of previous partner',
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
