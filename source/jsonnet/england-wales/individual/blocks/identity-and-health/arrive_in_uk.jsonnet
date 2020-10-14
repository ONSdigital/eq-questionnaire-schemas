local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, message) = {
  id: 'arrive-in-uk-question',
  title: title,
  type: 'General',
  description: [
    'Do not count short visits away from the UK',
  ],
  answers: [
    {
      id: 'arrive-in-uk-answer',
      mandatory: false,
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
          MANDATORY_DATE: 'Enter a valid date of arrival',
          SINGLE_DATE_PERIOD_TOO_EARLY: message,
          SINGLE_DATE_PERIOD_TOO_LATE: 'Enter a date of arrival that is in the past',
        },
      },
    },
  ],
};

local nonProxyTitle = 'When did you most recently arrive to live in the United Kingdom?';
local proxyTitle = {
  text: 'When did <em>{person_name}</em> most recently arrive to live in the United Kingdom?',
  placeholders: [
    placeholders.personName(),
  ],
};
local nonProxyErrorMessage = 'Enter a date of arrival that is after your date of birth';
local proxyErrorMessage = 'Enter a date of arrival that is after their date of birth';

function(region_code, census_month_year_date) {
  type: 'Question',
  id: 'arrive-in-uk',
  page_title: 'Arrived to live in the UK',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyErrorMessage),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyErrorMessage),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'length-of-stay-in-uk',
        when: [rules.under1],
      },
    },
    {
      goto: {
        block: 'length-of-stay-in-uk',
        when: [
          {
            id: 'arrive-in-uk-answer',
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
            id: 'arrive-in-uk-answer',
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
            id: 'arrive-in-uk-answer',
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
        block: 'location-one-year-ago',
      },
    },
  ],
}
