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
      min_value: {
        value: 0,
      },
      max_value: {
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
  text: 'What was {person_name_possessive} age on their last birthday?',
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
