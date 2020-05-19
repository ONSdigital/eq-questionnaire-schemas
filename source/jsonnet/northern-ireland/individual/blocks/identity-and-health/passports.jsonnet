local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, definitionContent, otherDescription) = {
  id: 'passports-question',
  title: title,
  description: '',
  type: 'MutuallyExclusive',
  mandatory: false,
  definitions: [
    {
      title: 'What official documents can be included?',
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

local nonProxyDefinitionContent = 'You may have other travel documents that show you are a citizen of a particular country. Please complete this question as if your travel documents are passports.';
local nonProxyTitle = 'What passports do you hold?';
local proxyDefinitionContent = 'They may have other travel documents that show they are a citizen of a particular country. Please complete this question as if their travel documents are passports.';
local proxyTitle = {
  text: 'What passports does <em>{person_name}</em> hold?',
  placeholders: [
    placeholders.personName,
  ],
};
local proxyLabel = 'Please specify the passports held';

{
  type: 'Question',
  id: 'passports',
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
