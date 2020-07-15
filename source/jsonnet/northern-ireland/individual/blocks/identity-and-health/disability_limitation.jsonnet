local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'health-conditions-or-illnesses-limitations-question',
  title: title,
  guidance: {
    contents: [
      {
        description: 'Include problems relating to old age',
      },
    ],
  },
  type: 'General',
  answers: [
    {
      id: 'health-conditions-or-illnesses-limitations-answer',
      mandatory: false,
      options: [
        {
          label: 'No',
          value: 'No',
        },
        {
          label: 'Yes, limited a little',
          value: 'Yes, limited a little',
        },
        {
          label: 'Yes, limited a lot',
          value: 'Yes, limited a lot',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Are your day-to-day activities limited because of a health problem or disability which has lasted, or is expected to last, at least 12 months?';

local proxyTitle = {
  text: 'Are <em>{person_name_possessive}</em> day-to-day activities limited because of a health problem or disability which has lasted, or is expected to last, at least 12 months?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'health-conditions-or-illnesses-limitations',
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
