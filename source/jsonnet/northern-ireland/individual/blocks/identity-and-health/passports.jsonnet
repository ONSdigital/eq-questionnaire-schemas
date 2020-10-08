local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, definitionContent, otherDescription) = {
  id: 'passports-question',
  title: title,
  type: 'MutuallyExclusive',
  mandatory: false,
  definitions: [
    {
      title: 'What passports and travel documents to include',
      contents: [
        {
          description: definitionContent,
        },
      ],
    },
  ],
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

local nonProxyDefinitionContent = 'Include current passports and any other travel documents, including those that are expired, if you are entitled to renew them.';
local nonProxyTitle = 'What passports do you hold?';
local proxyDefinitionContent = 'Include current passports and any other travel documents, including those that are expired, if they are entitled to renew them.';
local proxyTitle = {
  text: 'What passports does <em>{person_name}</em> hold?',
  placeholders: [
    placeholders.personName(),
  ],
};
local proxyLabel = 'Please specify the passports held';

{
  type: 'Question',
  id: 'passports',
  page_title: 'Passports',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDefinitionContent, 'You can enter your passports on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyDefinitionContent, 'You can enter their passports on the next question'),
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
        block: 'national-identity',
      },
    },
  ],
}
