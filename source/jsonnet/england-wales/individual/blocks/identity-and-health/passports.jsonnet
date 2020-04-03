local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, label, definitionContent, otherDescription) = {
  id: 'passports-question',
  title: title,
  description: '',
  type: 'MutuallyExclusive',
  mandatory: false,
  guidance: {
    contents: [
      {
        title: 'Include',
        list: [
          'current passports and any other travel documents, such as ID cards, that show citizenship of a particular country or countries',
          description,
        ],
      },
    ],
  },
  answers: [
    {
      id: 'passports-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'United Kingdom',
          value: 'United Kingdom',
        },
        {
          label: 'Ireland',
          value: 'Ireland',
        },
        {
          label: 'Other',
          value: 'Other',
          description: otherDescription,
        },
      ],
    },
    {
      id: 'passports-answer-exclusive',
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

local nonProxyTitle = 'What passports do you hold?';
local nonProxyLabel = 'Enter the passports you hold';
local proxyTitle = {
  text: 'What passports does <em>{person_name}</em> hold?',
  placeholders: [
    placeholders.personName,
  ],
};
local proxyLabel = 'Enter passports held';

{
  type: 'Question',
  id: 'passports',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyLabel, nonProxyDefinitionContent, 'You can enter your passports on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyLabel, proxyDefinitionContent, 'You can enter their passports on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'passports-additional-other',
        when: [
          {
            id: 'passports-answer',
            condition: 'contains any',
            values: ['United Kingdom', 'Ireland'],
          },
          {
            id: 'passports-answer',
            condition: 'contains',
            value: 'Other',
          },
        ],
      },
    },
    {
      goto: {
        block: 'passports-other',
        when: [
          {
            id: 'passports-answer',
            condition: 'contains',
            value: 'Other',
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
