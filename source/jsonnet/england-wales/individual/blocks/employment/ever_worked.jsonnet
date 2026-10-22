local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local title(isProxy) = (
  if isProxy then
    {
      text: 'Has <strong>{person_name}</strong> ever done any paid work?',
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
      when: rules.isNotProxy,
    },
    {
      question: question(isProxy=true),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      section: 'End',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'ever-worked-answer',
          },
          'No, have never worked',
        ],
      },
    },
    {
      section: 'End',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'ever-worked-answer',
          },
          'No, has never worked',
        ],
      },
    },
    {
      section: 'End',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'ever-worked-answer',
          },
          null,
        ],
      },
    },
    {
      block: 'main-job-introduction',
    },
  ],
}
