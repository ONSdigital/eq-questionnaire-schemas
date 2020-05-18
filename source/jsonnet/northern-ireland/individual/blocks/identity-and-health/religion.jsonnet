local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What religion, religious denomination or body do you belong to?';
local proxyTitle = {
  text: 'What religion, religious denomination or body does <em>{person_name}</em> belong to?',
  placeholders: [
    placeholders.personName,
  ],
};

local question(title, otherReligionDescription) = {
  id: 'religion-question',
  title: title,
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'religion-answer',
      mandatory: false,
      type: 'Checkbox',
      label: '',
      options: [
        {
          label: 'Roman Catholic',
          value: 'Roman Catholic',
        },
        {
          label: 'Presbyterian Church in Ireland',
          value: 'Presbyterian Church in Ireland',
        },
        {
          label: 'Church of Ireland',
          value: 'Church of Ireland',
        },
        {
          label: 'Methodist Church in Ireland',
          value: 'Methodist Church in Ireland',
        },
        {
          label: 'Other',
          value: 'Other',
          description: otherReligionDescription,
        },
      ],
    },
    {
      id: 'religion-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'None',
          value: 'None',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'religion',
  question_variants: [
    {
      question: question(nonProxyTitle, 'You can enter your religion on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, 'You can enter their religion on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'religion-other',
        when: [
          {
            id: 'religion-answer',
            condition: 'contains',
            value: 'Other',
          },
        ],
      },
    },
    {
      goto: {
        block: 'no-religion',
        when: [
          {
            id: 'religion-answer',
            condition: 'not set',
          },
        ],
      },
    },
    {
      goto: {
        block: 'health',
        when: [rules.under3],
      },
    },
    {
      goto: {
        block: 'language',
      },
    },
  ],
}
