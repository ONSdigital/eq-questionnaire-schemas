local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'date-of-birth-question',
  title: title,
  description: ['For example, 31 3 1980'],
  type: 'General',
  answers: [
    {
      id: 'date-of-birth-answer',
      mandatory: true,
      type: 'Date',
      minimum: {
        value: std.extVar('census_date'),
        offset_by: {
          years: -115,
          months: -11,
          days: -30,
        },
      },
      maximum: {
        value: 'now',
      },
      validation: {
        messages: {
          MANDATORY_DATE: 'Enter a date of birth',
          INVALID_DATE: 'Enter a valid date of birth',
          SINGLE_DATE_PERIOD_TOO_EARLY: 'Enter a date of birth after %(min)s',
          SINGLE_DATE_PERIOD_TOO_LATE: 'Enter a date of birth before %(max)s',
        },
      },
    },
  ],
};

local nonProxyTitle = 'What is your date of birth?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> date of birth?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'date-of-birth',
  page_title: 'Date of birth',
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
}
