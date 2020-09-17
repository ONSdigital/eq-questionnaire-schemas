local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  id: 'passports-question',
  title: title,
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
          description: 'You can enter these passports on the next question',
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
  page_title: 'Passports',
  question_variants: [
    {
      question: question(nonProxyTitle, 'passports and travel documents that have expired, if you are entitled to renew them'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, 'passports and travel documents that have expired, if they are entitled to renew them'),
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
