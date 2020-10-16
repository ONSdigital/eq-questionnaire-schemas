local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'Where does <em>{person_name}</em> mainly work?',
    placeholders: [
      placeholders.personName(),
    ],
  }
  else 'Where do you mainly work?'
);

local questionDescription(isProxy) = (
  if isProxy then 'If the <strong>coronavirus</strong> pandemic has affected where they mainly work, select the answer that best describes their <strong>current circumstances</strong>.'
  else 'If the <strong>coronavirus</strong> pandemic has affected where you mainly work, select the answer that best describes your <strong>current circumstances</strong>.'
);

local questionGuidance(isProxy) = (
  if isProxy then [
    {
      description: 'This is where they work most of the time in their main job.',
    },
    { description: 'For example, if they work from home three days a week and go to another place of work two days, select  “At or from home”.' },
  ]
  else [
    { description: 'This is where you work most of the time in your main job.' },
    { description: 'For example, if you work from home three days a week and go to another place of work two days, select “At or from home”.' },
  ]
);


local answerGuidance(isProxy) = (
  if isProxy then [
    {
      description: 'Their answer will help their community by allowing the government and councils to understand commuting patterns.',
    },
    { description: 'Information about their workplace and how they travel to work are used together to work out local public transport needs, develop transport policies and plan services.' },
  ]
  else [
    { description: 'Your answer will help your community by allowing the government and councils to understand commuting patterns.' },
    { description: 'Information about your workplace and how you travel to work are used together to work out local public transport needs, develop transport policies and plan services.' },
  ]
);


local question(isProxy) = {
  id: 'workplace-type-question',
  title: questionTitle(isProxy),
  definitions: [{
    title: 'What we mean by “mainly work”',
    contents: questionGuidance(isProxy),
  }],
  description: [
    questionDescription(isProxy),
  ],
  type: 'General',
  answers: [
    {
      guidance: {
        show_guidance: 'Why we ask for workplace',
        hide_guidance: 'Why we ask for workplace',
        contents: answerGuidance(isProxy),
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

{
  type: 'Question',
  id: 'workplace-type',
  page_title: 'Type of workplace',
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
