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

{
  type: 'Question',
  id: 'sex',
  page_title: 'Sex',
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
        block: 'marital-or-civil-partnership-status',
        when: [rules.over16],
      },
    },
    {
      goto: {
        block: 'marital-or-civil-partnership-status',
        when: [rules.lastBirthdayAgeOver(16)],
      },
    },
    {
      goto: {
        group: 'identity-and-health-group',
        when: [rules.schoolYearUnder4],
      },
    },
    {
      goto: {
        group: 'identity-and-health-group',
        when: [rules.lastBirthdayAgeLessThan(4)],
      },
    },
    {
      goto: {
        block: 'in-education',
      },
    },
  ],
}
