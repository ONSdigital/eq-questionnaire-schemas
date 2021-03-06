local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'another-address-question',
  title: title,
  type: 'General',
  definitions: [
    {
      title: 'What we mean by “another address”',
      contents: [
        {
          description: 'This is a single address that is different to the one at the start of this questionnaire. This might be another parent or guardian’s address, a term-time address, a partner’s address or a holiday home.',
        },
      ],
    },
  ],
  description: [
    'This should be a single address and could be more than 30 days in a row or divided across the year',
  ],
  answers: [
    {
      id: 'another-address-answer',
      mandatory: false,
      options: [
        {
          label: 'No',
          value: 'No',
        },
        {
          label: 'Yes, an address within the UK',
          value: 'Yes, an address within the UK',
        },
        {
          label: 'Yes, an address outside the UK',
          value: 'Yes, an address outside the UK',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Do you stay at another address for more than 30 days a year?';
local proxyTitle = {
  text: 'Does <em>{person_name}</em> stay at another address for more than 30 days a year?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'another-address',
  page_title: 'Another address, more than 30 days a year',
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
        group: 'identity-and-health-group',
        when: [
          {
            id: 'another-address-answer',
            condition: 'not set',
          },
          rules.under5,
        ],
      },
    },
    {
      goto: {
        group: 'identity-and-health-group',
        when: [
          {
            id: 'another-address-answer',
            condition: 'equals',
            value: 'No',
          },
          rules.under5,
        ],
      },
    },
    {
      goto: {
        block: 'in-education',
        when: [
          {
            id: 'another-address-answer',
            condition: 'equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        block: 'other-address-uk',
        when: [
          {
            id: 'another-address-answer',
            condition: 'equals',
            value: 'Yes, an address within the UK',
          },
        ],
      },
    },
    {
      goto: {
        block: 'another-address-outside-uk',
        when: [
          {
            id: 'another-address-answer',
            condition: 'equals',
            value: 'Yes, an address outside the UK',
          },
        ],
      },
    },
    {
      goto: {
        block: 'in-education',
      },
    },
  ],
}
