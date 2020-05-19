local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, label, definitionContent) = {
  id: 'passports-question',
  title: title,
  description: '',
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

local nonProxyDefinitionContent = 'Include current passports and any other travel documents, including those that are expired, if you are entitled to renew them.';
local nonProxyTitle = 'What passports do you hold?';
local nonProxyLabel = 'Please specify the passports you hold';
local proxyDefinitionContent = 'Include current passports and any other travel documents, including those that are expired, if they are entitled to renew them.';
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
      question: question(nonProxyTitle, nonProxyLabel, nonProxyDefinitionContent),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyLabel, proxyDefinitionContent),
      when: [rules.isProxy],
    },
  ],
}
