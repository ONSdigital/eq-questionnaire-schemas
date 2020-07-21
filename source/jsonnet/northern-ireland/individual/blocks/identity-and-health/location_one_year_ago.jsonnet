local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  id: 'location-one-year-ago-question',
  title: title,
  type: 'General',
  description: [
    description,
  ],
  answers: [
    {
      id: 'location-one-year-ago-answer',
      mandatory: false,
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
          label: 'Student term-time address in the UK',
          value: 'Student term-time address in the UK',
        },
        {
          label: 'Another address in the UK',
          value: 'Another address in the UK',
        },
        {
          label: 'An address outside the UK',
          value: 'An address outside the UK',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'One year ago, what was your usual address?';
local nonProxyDescription = 'If you had no usual address one year ago, state the address where you were staying';

local proxyTitle = {
  text: 'One year ago, what was <em>{person_name_possessive}</em> usual address?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local proxyDescription = 'If they had no usual address one year ago, state the address where they were staying';

{
  type: 'Question',
  id: 'location-one-year-ago',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyDescription),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'address-one-year-ago-outside-uk',
        when: [
          {
            id: 'location-one-year-ago-answer',
            condition: 'equals',
            value: 'An address outside the UK',
          },
        ],
      },
    },
    {
      goto: {
        block: 'address-one-year-ago',
        when: [
          {
            id: 'location-one-year-ago-answer',
            condition: 'equals any',
            values: [
              'Another address in the UK',
              'Student term-time address in the UK',
            ],
          },
        ],
      },
    },
    {
      goto: {
        block: 'passports',
      },
    },
  ],
}
