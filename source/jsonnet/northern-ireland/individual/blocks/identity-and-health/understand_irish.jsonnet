local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'understand-irish-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'understand-irish-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'No ability',
          value: 'No ability',
        },
        {
          label: 'Understand Irish',
          value: 'Understand Irish',
        },
        {
          label: 'Speak Irish',
          value: 'Speak Irish',
        },
        {
          label: 'Read Irish',
          value: 'Read Irish',
        },
        {
          label: 'Write Irish',
          value: 'Write Irish',
        },
      ],
    },
  ],
};

local nonProxyTitle = 'Can you understand, speak, read or write Irish?';
local proxyTitle = {
  text: 'Can <em>{person_name}</em> understand, speak, read or write Irish?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'understand-irish',
  page_title: 'Irish language skills',
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
        block: 'frequency-irish',
        when: [
          {
            id: 'understand-irish-answer',
            condition: 'contains',
            value: 'Speak Irish',
          },
        ],
      },
    },
    {
      goto: {
        block: 'understand-ulster-scots',
      },
    },
  ],
}
