local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'age-last-birthday-question',
  description: '',
  type: 'General',
  title: title,
  answers: [
    {
      id: 'age-last-birthday-answer',
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
};

local nonProxyTitle = 'What was your age on your last birthday?';

local proxyTitle = {
  text: 'What was <em>{person_name_possessive}</em> age on their last birthday?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'age-last-birthday',
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
        block: 'sex',
      },
    },
  ],
}
