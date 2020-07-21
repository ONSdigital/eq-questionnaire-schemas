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
      description: 'A question about gender identity will follow later on in the questionnaire',
    },
  ],
};

{
  type: 'Question',
  id: 'sex',
  question_variants: [
    {
      question: question(nonProxyTitle) + {
        guidance: guidance,
      },
      when: [rules.isNotProxy, rules.over16],
    },
    {
      question: question(proxyTitle) + {
        guidance: guidance,
      },
      when: [rules.isProxy, rules.over16],
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
        block: 'marital-or-civil-partnership-status',
        when: [
          rules.over15,
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
