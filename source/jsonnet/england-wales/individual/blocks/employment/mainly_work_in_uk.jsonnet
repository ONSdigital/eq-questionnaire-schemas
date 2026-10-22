local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'Does <strong>{person_name}</strong> mainly work in the UK?',
    placeholders: [
      placeholders.personName(),
    ],
  }
  else 'Do you mainly work in the UK?'
);

local question(isProxy) = {
  id: 'mainly-work-in-uk-question',
  title: questionTitle(isProxy),
  type: 'General',
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
      when: rules.isNotProxy,
    },
    {
      question: question(isProxy=true),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'workplace-address',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'workplace-type-answer',
              },
              null,
            ],
          },
          {
            '!=': [
              {
                source: 'answers',
                identifier: 'mainly-work-in-uk-answer',
              },
              'No',
            ],
          },
        ],
      },
    },
    {
      block: 'workplace-address',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'workplace-type-answer',
              },
              'At a workplace',
            ],
          },
          {
            '!=': [
              {
                source: 'answers',
                identifier: 'mainly-work-in-uk-answer',
              },
              'No',
            ],
          },
        ],
      },
    },
    {
      block: 'depot-address',
      when: {
        and: [
          {
            '==': [
              {
                source: 'answers',
                identifier: 'workplace-type-answer',
              },
              'Report to a depot',
            ],
          },
          {
            '!=': [
              {
                source: 'answers',
                identifier: 'mainly-work-in-uk-answer',
              },
              'No',
            ],
          },
        ],
      },
    },
    {
      block: 'mainly-work-outside-uk',
    },
  ],
}
