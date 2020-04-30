local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'marriage-type-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'marriage-type-answer',
      mandatory: false,
      options: [
        {
          label: 'Single, never married and never in a civil partnership',
          value: 'Single, never married and never in a civil partnership',
        },
        {
          label: 'Married',
          value: 'Married',
        },
        {
          label: 'In a civil partnership',
          value: 'In a civil partnership',
        },
        {
          label: 'Separated, but still legally married',
          value: 'Separated, but still legally married',
        },
        {
          label: 'Separated, but still legally in a civil partnership',
          value: 'Separated, but still legally in a civil partnership',
        },
        {
          label: 'Divorced',
          value: 'Divorced',
        },
        {
          label: 'Formerly in a civil partnership which is now legally dissolved',
          value: 'Formerly in a civil partnership which is now legally dissolved',
        },
        {
          label: 'Widowed',
          value: 'Widowed',
        },
        {
          label: 'Surviving partner from a civil partnership',
          value: 'Surviving partner from a civil partnership',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'What is your marital or civil partnership status?';

local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> marital or civil partnership status?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'marriage-type',
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
}
