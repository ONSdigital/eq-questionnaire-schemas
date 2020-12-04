local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local title(isProxy) = (
  if isProxy then
    {
      text: 'Has <em>{person_name}</em> ever done any paid work?',
      placeholders: [
        placeholders.personName(),
      ],
    }
  else 'Have you ever done any paid work?'
);

local label(isProxy) = (
  if isProxy then
    'No, has never worked'
  else 'No, have never worked'
);
local question(isProxy) = {
  id: 'ever-worked-question',
  title: title(isProxy),
  description: [
    '<strong>Furlough</strong> is considered paid work',
  ],
  type: 'General',
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
          label: label(isProxy),
          value: label(isProxy),
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'ever-worked',
  page_title: 'Ever done any paid work',
  question_variants: [
    {
      question: question(isProxy=false),
      when: [rules.isNotProxy],
    },
    {
      question: question(isProxy=true),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        section: 'End',
        when: [
          {
            id: 'ever-worked-answer',
            condition: 'equals',
            value: 'No, have never worked',
          },
        ],
      },
    },
    {
      goto: {
        section: 'End',
        when: [
          {
            id: 'ever-worked-answer',
            condition: 'equals',
            value: 'No, has never worked',
          },
        ],
      },
    },
    {
      goto: {
        section: 'End',
        when: [
          {
            id: 'ever-worked-answer',
            condition: 'not set',
          },
        ],
      },
    },
    {
      goto: {
        block: 'main-job-introduction',
      },
    },
  ],
}
