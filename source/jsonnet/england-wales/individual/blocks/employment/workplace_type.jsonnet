local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidanceContent, questionGuidance, questionDescription) = {
  id: 'workplace-type-question',
  title: title,
  definitions: [{
    title: 'What we mean by “mainly work”',
    contents: questionGuidance,
  }],
  description: [
    questionDescription,
  ],
  type: 'General',
  answers: [
    {
      guidance: {
        show_guidance: 'Why we ask for workplace',
        hide_guidance: 'Why we ask for workplace',
        contents: guidanceContent,
      },
      id: 'workplace-type-answer',
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

local proxyDescription = 'If the <strong>coronavirus</strong> pandemic has affected where they mainly work, select the answer that best describes their <strong>current circumstances</strong>.';
local nonProxyDescription = 'If the <strong>coronavirus</strong> pandemic has affected where you mainly work, select the answer that best describes your <strong>current circumstances</strong>.';

local proxyQuestionGuidance = [
  {
    description: 'This is where they work most of the time in their main job.',
  },
  {
    description: 'For example, if they work from home three days a week and go to another place of work two days, select  “At or from home”.',
  },
];

local nonProxyQuestionGuidance = [
  {
    description: 'This is where you work most of the time in your main job.',
  },
  {
    description: 'For example, if you work from home three days a week and go to another place of work two days, select “At or from home”.',
  },
];

local nonProxyTitle = 'Where do you mainly work?';
local proxyTitle = {
  text: 'Where does <em>{person_name}</em> mainly work?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'workplace-type',
  page_title: 'Type of workplace',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidanceContent, nonProxyQuestionGuidance, nonProxyDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyGuidanceContent, proxyQuestionGuidance, proxyDescription),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'mainly-work-in-uk',
        when: [
          {
            id: 'workplace-type-answer',
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
            id: 'workplace-type-answer',
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
