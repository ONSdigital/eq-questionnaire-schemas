local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'past-usual-address-household-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'past-usual-address-household-answer',
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
  text: 'Was {person_name_possessive} usual address one year ago, on {year_before_census_date}, the same as their usual address on {census_date}?',
  placeholders: [
    placeholders.personNamePossessive,
    placeholders.yearBeforeCensusDate,
    placeholders.censusDate,
  ],
};


{
  type: 'Question',
  id: 'past-usual-household-address',
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
        block: 'another-uk-address',
        when: [
          {
            id: 'past-usual-address-household-answer',
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
            id: 'past-usual-address-household-answer',
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
            id: 'past-usual-address-household-answer',
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
