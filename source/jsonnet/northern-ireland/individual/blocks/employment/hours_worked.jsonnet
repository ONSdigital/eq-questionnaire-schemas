local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  title: title,
  id: 'hours-worked-question',
  guidance: {
    contents: [
      {
        description: 'Include paid and unpaid overtime',
      },
    ],
  },
  type: 'General',
  answers: [
    {
      id: 'hours-worked-answer',
      mandatory: false,
      options: [
        {
          label: '0 to 15 hours a week',
          value: '0 to 15 hours a week',
        },
        {
          label: '16 to 30 hours a week',
          value: '16 to 30 hours a week',
        },
        {
          label: '31 to 48 hours a week',
          value: '31 to 48 hours a week',
        },
        {
          label: '49 hours or more a week',
          value: '49 hours or more a week',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'In your main job, how many hours a week do you usually work?';
local proxyTitle = {
  text: 'In <em>{person_name_possessive}</em> main job, how many hours a week do they usually work?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'In your main job, how many hours a week did you usually work?';
local pastProxyTitle = {
  text: 'In <em>{person_name_possessive}</em> main job, how many hours a week did they usually work?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'hours-worked',
  page_title: 'Hours worked',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitle),
      when: [rules.isNotProxy, rules.lastMainJob],
    },
    {
      question: question(pastProxyTitle),
      when: [rules.isProxy, rules.lastMainJob],
    },
  ],
  routing_rules: [
    {
      goto: {
        group: 'school-group',
        when: [{
          id: 'in-education-answer',
          condition: 'equals',
          value: 'Yes',
        }],
      },
    },
    {
      goto: {
        group: 'school-group',
        when: [{
          id: 'not-employed-status-last-seven-days-answer',
          condition: 'contains',
          value: 'Studying',
        }],
      },
    },
    {
      goto: {
        block: 'workplace-type',
      },
    },
  ],
}
