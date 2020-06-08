local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'marriage-type-question',
  title: title,
  instruction: 'Tell the respondent to turn to <strong>Showcard 8</strong> or show them the options below',
  type: 'General',
  answers: [
    {
      id: 'marriage-type-answer',
      mandatory: false,
      options: [
        {
          label: 'Never married and never registered a civil partnership',
          value: 'Never married and never registered a civil partnership',
        },
        {
          label: 'Married',
          value: 'Married',
        },
        {
          label: 'In a registered civil partnership',
          value: 'In a registered civil partnership',
        },
        {
          label: 'Separated, but still legally married',
          value: 'Separated, but still legally married',
        },
        {
          label: 'Separated, but still legally in a civil partnership',
          value: 'Separated, but still legally in a civil partnership',
        },
        {
          label: 'Divorced',
          value: 'Divorced',
        },
        {
          label: 'Formerly in a civil partnership which is now legally dissolved',
          value: 'Formerly in a civil partnership which is now legally dissolved',
        },
        {
          label: 'Widowed',
          value: 'Widowed',
        },
        {
          label: 'Surviving partner from a registered civil partnership',
          value: 'Surviving partner from a registered civil partnership',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = {
  text: 'On {census_date}, what was your legal marital or registered civil partnership status?',
  placeholders: [
    placeholders.censusDate,
  ],
};
local proxyTitle = {
  text: 'On {census_date}, what was <em>{person_name_possessive}</em> legal marital or registered civil partnership status?',
  placeholders: [
    placeholders.censusDate,
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'marriage-type',
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
