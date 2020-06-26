local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'date-of-birth-question',
  type: 'MutuallyExclusive',
  title: title,
  mandatory: false,
  answers: [
    {
      id: 'date-of-birth-answer',
      mandatory: false,
      type: 'Date',
      minimum: {
        value: std.extVar('census_date'),
        offset_by: {
          years: -115,
        },
      },
      maximum: {
        value: 'now',
      },
    },
    {
      id: 'date-of-birth-exclusive-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'Date of birth is not known',
          value: 'Date of birth is not known',
        },
      ],
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
        block: 'confirm-dob',
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
