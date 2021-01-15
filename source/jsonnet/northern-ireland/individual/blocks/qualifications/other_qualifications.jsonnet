local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'Have you achieved any other qualifications?';
local proxyTitle = {
  text: 'Has <em>{person_name}</em> achieved any other qualifications?',
  placeholders: [
    placeholders.personName(),
  ],
};

local question(title) = {
  id: 'other-qualifications-question',
  title: title,
  guidance: {
    contents: [
      {
        description: 'Include qualifications achieved either within or outside of Northern Ireland',
      },
    ],
  },
  type: 'General',
  answers: [
    {
      id: 'other-qualifications-answer',
      mandatory: false,
      type: 'Radio',
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No qualifications',
          value: 'No qualifications',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'other-qualifications',
  page_title: 'Any other qualifications',
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
