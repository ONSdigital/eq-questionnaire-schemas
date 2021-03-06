local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your country of birth?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> country of birth?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local question(title, elsewhereDescription) = {
  id: 'country-of-birth-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'country-of-birth-answer',
      mandatory: false,
      type: 'Radio',
      options: [
        {
          label: 'Northern Ireland',
          value: 'Northern Ireland',
        },
        {
          label: 'England',
          value: 'England',
        },
        {
          label: 'Scotland',
          value: 'Scotland',
        },
        {
          label: 'Wales',
          value: 'Wales',
        },
        {
          label: 'Republic of Ireland',
          value: 'Republic of Ireland',
        },
        {
          label: 'Elsewhere',
          value: 'Elsewhere',
          description: elsewhereDescription,
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'country-of-birth',
  page_title: 'Country of birth',
  question_variants: [
    {
      question: question(nonProxyTitle, 'You can enter your country of birth on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, 'You can enter their country of birth on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'country-of-birth-elsewhere',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'equals',
            value: 'Elsewhere',
          },
        ],
      },
    },
    {
      goto: {
        block: 'passports',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'equals',
            value: 'Northern Ireland',
          },
          rules.under1,
        ],
      },
    },
    {
      goto: {
        block: 'passports',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'equals',
            value: 'Northern Ireland',
          },
          rules.lastBirthdayAgeLessThan(1),
        ],
      },
    },
    {
      goto: {
        block: 'passports',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'not set',
          },
          rules.under1,
        ],
      },
    },
    {
      goto: {
        block: 'passports',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'not set',
          },
          rules.lastBirthdayAgeLessThan(1),
        ],
      },
    },
    {
      goto: {
        block: 'location-one-year-ago',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'not set',
          },
        ],
      },
    },
    {
      goto: {
        block: 'arrive-in-country',
        when: [
          {
            id: 'country-of-birth-answer',
            condition: 'not equals',
            value: 'Northern Ireland',
          },
        ],
      },
    },
    {
      goto: {
        block: 'location-one-year-ago',
      },
    },
  ],
}
