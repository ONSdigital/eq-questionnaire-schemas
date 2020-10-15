local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'Does <em>{person_name}</em> mainly work in the UK?',
    placeholders: [
      placeholders.personName(),
    ],
  }
  else 'Do you mainly work in the UK?'
);

local questionDescription(isProxy) = (
  if isProxy then 'If the <strong>coronavirus</strong> pandemic has affected where they mainly work, select the answer that best describes their <strong>current circumstances</strong>.'
  else 'If the <strong>coronavirus</strong> pandemic has affected where you mainly work, select the answer that best describes your <strong>current circumstances</strong>.'
);

local question(isProxy) = {
  id: 'mainly-work-in-uk-question',
  title: questionTitle(isProxy),
  type: 'General',
  description: [questionDescription(isProxy)],
  answers: [
    {
      id: 'mainly-work-in-uk-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No',
          value: 'No',
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'mainly-work-in-uk',
  page_title: 'Mainly work in the UK',
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
        block: 'workplace-address',
        when: [
          {
            id: 'workplace-type-answer',
            condition: 'not set',
          },
          {
            id: 'mainly-work-in-uk-answer',
            condition: 'not set',
          },
        ],
      },
    },
    {
      goto: {
        block: 'workplace-address',
        when: [
          {
            id: 'workplace-type-answer',
            condition: 'equals',
            value: 'At a workplace',
          },
          {
            id: 'mainly-work-in-uk-answer',
            condition: 'not equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        block: 'depot-address',
        when: [
          {
            id: 'workplace-type-answer',
            condition: 'equals',
            value: 'Report to a depot',
          },
          {
            id: 'mainly-work-in-uk-answer',
            condition: 'not equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        block: 'mainly-work-outside-uk',
      },
    },
  ],
}
