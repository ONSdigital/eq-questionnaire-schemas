local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'sex-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'sex-answer',
      mandatory: false,
      options: [
        {
          label: 'Female',
          value: 'Female',
        },
        {
          label: 'Male',
          value: 'Male',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'What is your sex?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> sex?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local guidance = {
  contents: [
    {
      description: 'A question about gender will follow',
    },
  ],
};

function(census_date) {
  type: 'Question',
  id: 'sex',
  question_variants: [
    {
      question: question(nonProxyTitle) + {
        guidance: guidance,
      },
      when: [rules.isNotProxy, rules.over16(census_date)],
    },
    {
      question: question(proxyTitle) + {
        guidance: guidance,
      },
      when: [rules.isProxy, rules.over16(census_date)],
    },
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
        block: 'marriage-type',
        when: [
          rules.over15(census_date),
        ],
      },
    },
    {
      goto: {
        block: 'another-address',
      },
    },
  ],
}
