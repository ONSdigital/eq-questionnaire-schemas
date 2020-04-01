local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyDescription = 'passports and travel documents that have expired, if you are entitled to renew them';
local proxyDescription = 'passports and travel documents that have expired, if they are entitled to renew them';

local question(title, description, label) = {
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
          description: 'Select to enter answer',
          detail_answer: {
            id: 'passport-answer-other',
            type: 'TextField',
            mandatory: false,
            label: label,
          },
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
      question: question(nonProxyTitle, nonProxyDescription, nonProxyLabel),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyDescription, proxyLabel),
      when: [rules.isProxy],
    },
  ],
}
