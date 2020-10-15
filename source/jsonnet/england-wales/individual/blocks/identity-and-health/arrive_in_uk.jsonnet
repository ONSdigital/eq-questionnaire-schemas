local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'When did <em>{person_name}</em> most recently arrive to live in the United Kingdom?',
    placeholders: [
      placeholders.personName(),
    ],
  }
  else 'When did you most recently arrive to live in the United Kingdom?'
);

local errorMessage(isProxy) = (
  if isProxy then 'Enter a date of arrival that is after their date of birth'
  else 'Enter a date of arrival that is after their date of birth'
);

local question(isProxy) = {
  id: 'arrive-in-uk-question',
  title: questionTitle(isProxy),
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
          SINGLE_DATE_PERIOD_TOO_EARLY: errorMessage(isProxy),
          SINGLE_DATE_PERIOD_TOO_LATE: 'Enter a date of arrival that is in the past',
        },
      },
    },
  ],
};

function(region_code, census_month_year_date) {
  type: 'Question',
  id: 'arrive-in-uk',
  page_title: 'Arrived to live in the UK',
  question_variants: [
    {
      question: question(isProxy=false),
      when: [rules.isNotProxy],
    },
    {
      question: question(isProxy=true),
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
