local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'understand-ulster-scots-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'understand-ulster-scots-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'No ability',
          value: 'No ability',
        },
        {
          label: 'Understand Ulster-Scots',
          value: 'Understand Ulster-Scots',
        },
        {
          label: 'Speak Ulster-Scots',
          value: 'Speak Ulster-Scots',
        },
        {
          label: 'Read Ulster-Scots',
          value: 'Read Ulster-Scots',
        },
        {
          label: 'Write Ulster-Scots',
          value: 'Write Ulster-Scots',
        },
      ],
    },
  ],
};

local nonProxyTitle = 'Can you understand, speak, read or write Ulster-Scots?';
local proxyTitle = {
  text: 'Can <em>{person_name}</em> understand, speak, read or write Ulster-Scots?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'understand-ulster-scots',
  page_title: 'Ulster-Scots language skills',
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
        block: 'frequency-ulster-scots',
        when: [
          {
            id: 'understand-ulster-scots-answer',
            condition: 'contains',
            value: 'Speak Ulster-Scots',
          },
        ],
      },
    },
    {
      goto: {
        block: 'health',
      },
    },
  ],
}
