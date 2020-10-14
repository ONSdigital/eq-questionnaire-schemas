local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  id: 'address-one-year-ago-question',
  title: title,
  description: [description],
  type: 'General',
  answers: [
    {
      id: 'address-one-year-ago-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No, living elsewhere in the UK',
          value: 'No, living elsewhere in the UK',
        },
        {
          label: 'No, living outside the UK',
          value: 'No, living outside the UK',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = {
  text: 'Was your usual address one year ago, on {year_before_census_date}, the same as your usual address on {census_date}?',
  placeholders: [
    placeholders.yearBeforeCensusDate,
    placeholders.censusDate,
  ],
};
local proxyTitle = {
  text: 'Was <em>{person_name_possessive}</em> usual address one year ago, on {year_before_census_date}, the same as their usual address on {census_date}?',
  placeholders: [
    placeholders.personNamePossessive,
    placeholders.yearBeforeCensusDate,
    placeholders.censusDate,
  ],
};

local nonProxyDescription = 'If the <strong>coronavirus</strong> pandemic affected your usual address one year ago, answer about where you were living <strong>before your circumstances changed</strong>.';

local proxyDescription = 'If the <strong>coronavirus</strong> pandemic affected their usual address one year ago, answer about where they were living <strong>before their circumstances changed</strong>.';

{
  type: 'Question',
  id: 'address-one-year-ago',
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
        block: 'another-uk-address',
        when: [
          {
            id: 'address-one-year-ago-answer',
            condition: 'not equals',
            value: 'No, living outside the UK',
          },
          rules.under16,
        ],
      },
    },
    {
      goto: {
        block: 'employment-status',
        when: [
          {
            id: 'address-one-year-ago-answer',
            condition: 'not equals',
            value: 'No, living outside the UK',
          },
          rules.over16,
        ],
      },
    },
    {
      goto: {
        block: 'employment-status',
        when: [
          {
            id: 'address-one-year-ago-answer',
            condition: 'not equals',
            value: 'No, living outside the UK',
          },
          rules.estimatedAge,
        ],
      },
    },
    {
      goto: {
        block: 'length-of-stay',
      },
    },
  ],
}
