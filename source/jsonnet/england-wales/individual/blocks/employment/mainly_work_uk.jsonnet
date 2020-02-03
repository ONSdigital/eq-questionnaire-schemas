local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'mainly-work-in-uk-question',
  title: title,
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

local nonProxyTitle = 'Do you mainly work in the UK?';
local proxyTitle = {
  text: 'Does <em>{person_name}</em> mainly work in the UK?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'mainly-work-in-uk',
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
        block: 'employer-address-workplace',
        when: [
          {
            id: 'employer-type-of-address-answer',
            condition: 'equals',
            value: 'At a workplace',
          },
          {
            id: 'mainly-work-in-uk-answer',
            condition: 'equals',
            value: 'Yes',
          },
        ],
      },
    },
    {
      goto: {
        block: 'employer-address-depot',
        when: [
          {
            id: 'employer-type-of-address-answer',
            condition: 'equals',
            value: 'Report to a depot',
          },
          {
            id: 'mainly-work-in-uk-answer',
            condition: 'equals',
            value: 'Yes',
          },
        ],
      },
    },
    {
      goto: {
        block: 'work-outside-uk',
      },
    },
  ],
}
