local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'marital-or-civil-partnership-status-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'marital-or-civil-partnership-status-answer',
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

local gotoRule(blockId, whenValue) = {
  goto: {
    block: blockId,
    when: [
      {
        id: 'marital-or-civil-partnership-status-answer',
        condition: 'equals',
        value: whenValue,
      },
    ],
  },
};

local nonProxyTitle = {
  text: 'On {census_date}, what is your legal marital or registered civil partnership status?',
  placeholders: [
    placeholders.censusDate,
  ],
};
local proxyTitle = {
  text: 'On {census_date}, what is <em>{person_name_possessive}</em> legal marital or registered civil partnership status?',
  placeholders: [
    placeholders.censusDate,
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'marital-or-civil-partnership-status',
  page_title: 'Legal marital or registered civil partnership status',
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
    gotoRule('another-address', 'Never married and never registered a civil partnership'),
    gotoRule('sex-of-current-spouse', 'Married'),
    gotoRule('sex-of-current-partner', 'In a registered civil partnership'),
    gotoRule('sex-of-current-spouse', 'Separated, but still legally married'),
    gotoRule('sex-of-current-partner', 'Separated, but still legally in a civil partnership'),
    gotoRule('sex-of-previous-spouse', 'Divorced'),
    gotoRule('sex-of-previous-partner', 'Formerly in a civil partnership which is now legally dissolved'),
    gotoRule('sex-of-previous-spouse', 'Widowed'),
    gotoRule('sex-of-previous-partner', 'Surviving partner from a registered civil partnership'),
    {
      goto: {
        block: 'another-address',
      },
    },
  ],
}
