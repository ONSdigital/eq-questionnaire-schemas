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
          label: {
            text: '{household_address}',
            placeholders: [
              placeholders.address,
            ],
          },
          value: '{household_address}',
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

local nonProxyTitle = {
  text: 'One year ago, on {year_before_census_date}, what was your usual address?',
  placeholders: [
    placeholders.yearBeforeCensusDate,
  ],
};
local proxyTitle = {
  text: 'One year ago, on {year_before_census_date}, what was <em>{person_name_possessive}</em> usual address?',
  placeholders: [
    placeholders.personNamePossessive,
    placeholders.yearBeforeCensusDate,
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
            value: 'An address outside the UK',
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
            value: 'An address outside the UK',
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
            value: 'An address outside the UK',
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
