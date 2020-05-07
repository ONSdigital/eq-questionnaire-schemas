local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'term-time-location-question',
  type: 'General',
  title: title,
  answers: [
    {
      id: 'term-time-location-answer',
      mandatory: true,
      type: 'Radio',
      options: [
        {
          label: {
            text: '{household_address}',
            placeholders: [
              placeholders.address,
            ],
          },
          value: '{household_address}',
        },
        {
          label: 'At another address in the UK',
          value: 'At another address in the UK',
        },
        {
          label: 'At another address outside the UK',
          value: 'At another address outside the UK',
        },
      ],
    },
  ],
};

local nonProxyTitle = 'During term time, where do you usually live?';
local proxyTitle = {
  text: 'During term time, where does <em>{person_name}</em> usually live?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'term-time-location',
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
        block: 'term-time-country-outside-uk',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: 'At another address outside the UK',
          },
        ],
      },
    },
    {
      goto: {
        block: 'term-time-address',
        when: [
          {
            id: 'term-time-location-answer',
            condition: 'equals',
            value: 'At another address in the UK',
          },
        ],
      },
    },
    {
      goto: {
        group: 'identity-and-health-group',
      },
    },
  ],
}
