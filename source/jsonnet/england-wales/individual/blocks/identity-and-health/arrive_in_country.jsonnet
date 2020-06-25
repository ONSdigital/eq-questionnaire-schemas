local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'arrive-in-country-question',
  title: title,
  type: 'General',
  description: 'Do not count short visits away from the UK',
  answers: [
    {
      id: 'arrive-in-country-answer',
      mandatory: true,
      type: 'MonthYearDate',
      minimum: {
        value: {
          source: 'answers',
          identifier: 'date-of-birth-answer',
        },
      },
      maximum: {
        value: 'now',
      },
      validation: {
        messages: {
          MANDATORY_DATE: 'Enter date of arrival to continue',
        },
      },
    },
  ],
};

local nonProxyTitle = 'When did you most recently arrive to live in the United Kingdom?';
local proxyTitle = {
  text: 'When did <em>{person_name}</em> most recently arrive to live in the United Kingdom?',
  placeholders: [
    placeholders.personName,
  ],
};

function(region_code, census_month_year_date) {
  type: 'Question',
  id: 'arrive-in-country',
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
        block: 'length-of-stay',
        when: [rules.under1],
      },
    },
    {
      goto: {
        block: 'length-of-stay',
        when: [
          {
            id: 'arrive-in-country-answer',
            condition: 'greater than',
            date_comparison: {
              value: census_month_year_date,
              offset_by: {
                years: -1,
              },
            },
          },
        ],
      },
    },
    {
      goto: {
        block: 'when-arrive-in-uk',
        when: [
          {
            id: 'arrive-in-country-answer',
            condition: 'not set',
          },
        ],
      },
    },
    {
      goto: {
        block: 'when-arrive-in-uk',
        when: [
          {
            id: 'arrive-in-country-answer',
            condition: 'equals',
            date_comparison: {
              value: census_month_year_date,
              offset_by: {
                years: -1,
              },
            },
          },
        ],
      },
    },
    {
      goto: {
        block: 'past-usual-household-address',
      },
    },
  ],
}
