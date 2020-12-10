local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  id: 'employment-status-last-seven-days-question',
  title: title,
  type: 'MutuallyExclusive',
  mandatory: true,
  description: [description],
  guidance: {
    contents: [
      {
        description: 'Include casual or temporary work, even if only for one hour',
      },
    ],
  },
  answers: [
    {
      id: 'employment-status-last-seven-days-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'Working as an employee',
          value: 'Working as an employee',
        },
        {
          label: 'Self-employed or freelance',
          value: 'Self-employed or freelance',
        },
        {
          label: 'Temporarily away from work ill, on holiday or temporarily laid off',
          value: 'Temporarily away from work ill, on holiday or temporarily laid off',
        },
        {
          label: 'On maternity or paternity leave',
          value: 'On maternity or paternity leave',
        },
        {
          label: 'Doing any other kind of paid work',
          value: 'Doing any other kind of paid work',
        },
      ],
    },
    {
      id: 'employment-status-last-seven-days-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'None of these apply',
          value: 'None of these apply',
        },
      ],
    },
  ],
};

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'In the last seven days, was <em>{person_name}</em> doing any of the following?',
    placeholders: [
      placeholders.personName(),
    ],
  }
  else 'In the last seven days, were you doing any of the following?'
);

local questionDescription(isProxy) = (
  if isProxy then 'If they have a job but have been off work on <em>furlough</em>, select “Temporarily away from work ill, on holiday or temporarily laid off”';
  else 'If you have a job but have been off work on <em>furlough</em>, select “Temporarily away from work ill, on holiday or temporarily laid off”';
);

{
  type: 'Question',
  id: 'employment-status-last-seven-days',
  page_title: 'Employment status in the last seven days',
  question_variants: [
    {
      question: question(questionTitle(false), questionDescription(false)),
      when: [rules.isNotProxy],
    },
    {
      question: question(questionTitle(true), questionDescription(true)),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'not-employed-status-last-seven-days',
        when: [
          rules.lastMainJob,
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
