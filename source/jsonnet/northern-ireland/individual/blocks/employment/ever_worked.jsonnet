local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, label) = {
  id: 'ever-worked-question',
  title: title,
  type: 'General',
  description: ['<em>Furlough</em> is considered paid work'],
  answers: [
    {
      id: 'ever-worked-answer',
      mandatory: true,
      options: [
        {
          label: 'Yes, in the last 12 months',
          value: 'Yes, in the last 12 months',
        },
        {
          label: 'Yes, but not in the last 12 months',
          value: 'Yes, but not in the last 12 months',
        },
        {
          label: label,
          value: label,
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Have you ever done any paid work?';
local nonProxyLabel = 'No, have never worked';

local proxyTitle = {
  text: 'Has <em>{person_name}</em> ever done any paid work?',
  placeholders: [
    placeholders.personName(),
  ],
};
local proxyLabel = 'No, has never worked';

{
  type: 'Question',
  id: 'ever-worked',
  page_title: 'Ever done any paid work',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyLabel),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyLabel),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'main-job-introduction',
        when: [rules.hasWorked],
      },
    },
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
        section: 'End',
      },
    },
  ],
}
