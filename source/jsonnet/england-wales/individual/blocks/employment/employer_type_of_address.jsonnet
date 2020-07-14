local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidanceContent) = {
  id: 'employer-type-of-address-question',
  title: title,
  type: 'General',
  answers: [
    {
      guidance: {
        show_guidance: 'Why we ask for workplace',
        hide_guidance: 'Why we ask for workplace',
        contents: guidanceContent,
      },
      id: 'employer-type-of-address-answer',
      mandatory: false,
      options: [
        {
          label: 'At a workplace',
          value: 'At a workplace',
        },
        {
          label: 'Report to a depot',
          value: 'Report to a depot',
        },
        {
          label: 'At or from home',
          value: 'At or from home',
        },
        {
          label: 'An offshore installation',
          value: 'An offshore installation',
        },
        {
          label: 'No fixed place',
          value: 'No fixed place',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyGuidanceContent = [
  {
    description: 'Your answer will help your community by allowing the government and councils to understand commuting patterns.',
  },
  {
    description: 'Information about your workplace and how you travel to work are used together to work out local public transport needs, develop transport policies and plan services.',
  },
];
local proxyGuidanceContent = [
  {
    description: 'Their answer will help their community by allowing the government and councils to understand commuting patterns.',
  },
  {
    description: 'Information about their workplace and how they travel to work are used together to work out local public transport needs, develop transport policies and plan services.',
  },
];

local nonProxyTitle = 'Where do you mainly work?';
local proxyTitle = {
  text: 'Where does <em>{person_name}</em> mainly work?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'workplace-type',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidanceContent),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyGuidanceContent),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'mainly-work-in-uk',
        when: [
          {
            id: 'employer-type-of-address-answer',
            condition: 'equals any',
            values: [
              'At a workplace',
              'Report to a depot',
            ],
          },
        ],
      },
    },
    {
      goto: {
        block: 'mainly-work-in-uk',
        when: [
          {
            id: 'employer-type-of-address-answer',
            condition: 'not set',
          },
        ],
      },
    },
    {
      goto: {
        section: 'End',
      },
    },
  ],
}
