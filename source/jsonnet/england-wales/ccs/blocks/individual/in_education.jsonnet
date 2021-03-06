local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'in-education-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'in-education-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No',
          value: 'No',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyUnder19Title = {
  text: 'On {census_date}, were you a schoolchild or student in full-time education?',
  placeholders: [
    placeholders.censusDate,
  ],
};

local proxyUnder19Title = {
  text: 'On {census_date}, was <em>{person_name}</em> a schoolchild or student in full-time education?',
  placeholders: [
    placeholders.personName(),
    placeholders.censusDate,
  ],
};

local nonProxyOver19Title = {
  text: 'On {census_date}, were you a student in full-time education?',
  placeholders: [
    placeholders.censusDate,
  ],
};

local proxyOver19Title = {
  text: 'On {census_date}, was <em>{person_name}</em> a student in full-time education?',
  placeholders: [
    placeholders.personName(),
    placeholders.censusDate,
  ],
};

{
  type: 'Question',
  id: 'in-education',
  question_variants: [
    {
      question: question(nonProxyOver19Title),
      when: [rules.isNotProxy, rules.over19],
    },
    {
      question: question(proxyOver19Title),
      when: [rules.isProxy, rules.over19],
    },
    {
      question: question(nonProxyOver19Title),
      when: [rules.isNotProxy, rules.estimatedAge],
    },
    {
      question: question(proxyOver19Title),
      when: [rules.isProxy, rules.estimatedAge],
    },
    {
      question: question(nonProxyUnder19Title),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyUnder19Title),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'term-time-location',
        when: [
          {
            id: 'in-education-answer',
            condition: 'equals',
            value: 'Yes',
          },
        ],
      },
    },
    {
      goto: {
        block: 'address-one-year-ago',
      },
    },
  ],
}
