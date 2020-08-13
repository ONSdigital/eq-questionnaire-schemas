local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, mandatory) = {
  id: 'date-of-birth-question',
  title: title,
  description: [
    'For example, 31 3 1980',
  ],
  type: 'General',
  answers: [
    {
      id: 'date-of-birth-answer',
      mandatory: mandatory,
      type: 'Date',
      validation: {
        messages: {
          MANDATORY_DATE: 'Enter a date of birth',
        },
      },
      minimum: {
        value: std.extVar('census_date'),
        offset_by: {
          years: -115,
          months: -2,
          days: -20,
        },
      },
      maximum: {
        value: 'now',
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
  question_variants: [
    {
      question: question(nonProxyTitle, true),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, false),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'confirm-age',
        when: [{
          id: 'date-of-birth-answer',
          condition: 'set',
        }],
      },
    },
    {
      goto: {
        block: 'age-last-birthday',
      },
    },
  ],
}
