local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'In <em>{person_name_possessive}</em> main job, how many hours a week do they usually work?',
    placeholders: [
      placeholders.personNamePossessive,
    ],
  }
  else 'In your main job, how many hours a week do you usually work?'
);

local questionDescription(isProxy) = (
  if isProxy then 'If the <strong>coronavirus</strong> pandemic has affected their working hours, select the answer that best describes their <strong>current circumstances</strong>.'
  else 'If the <strong>coronavirus</strong> pandemic has affected your working hours, select the answer that best describes your <strong>current circumstances</strong>.'
);

local question(isProxy) = {
  title: questionTitle(isProxy),
  id: 'hours-worked-question',
  guidance: {
    contents: [
      {
        description: 'Include paid and unpaid overtime',
      },
    ],
  },
  type: 'General',
  description: [
    questionDescription(isProxy),
  ],
  answers: [
    {
      id: 'hours-worked-answer',
      mandatory: false,
      options: [
        {
          label: '0 to 15 hours',
          value: '0 to 15 hours',
        },
        {
          label: '16 to 30 hours',
          value: '16 to 30 hours',
        },
        {
          label: '31 to 48 hours',
          value: '31 to 48 hours',
        },
        {
          label: '49 hours or more',
          value: '49 hours or more',
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'hours-worked',
  page_title: 'Hours worked',
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
}
