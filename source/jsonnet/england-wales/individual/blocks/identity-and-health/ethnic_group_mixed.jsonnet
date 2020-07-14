local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyGuidance = 'Why your answer is important';
local proxyGuidance = 'Why their answer is important';

local nonProxyDefinitionDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDefinitionDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local question(title, guidance, definitionDescription, mixedMultipleBackgroundDescription) = {
  id: 'mixed-ethnic-group-question',
  title: title,
  type: 'General',
  answers: [
    {
      guidance: {
        show_guidance: guidance,
        hide_guidance: guidance,
        contents: [
          {
            description: definitionDescription,
            list: [
              'provide services and share funding fairly',
              'understand and represent everyone’s interests',
            ],
          },
        ],
      },
      id: 'mixed-ethnic-group-answer',
      mandatory: false,
      options: [
        {
          label: 'White and Black Caribbean',
          value: 'White and Black Caribbean',
        },
        {
          label: 'White and Black African',
          value: 'White and Black African',
        },
        {
          label: 'White and Asian',
          value: 'White and Asian',
        },
        {
          label: 'Any other Mixed or Multiple background',
          value: 'Any other Mixed or Multiple background',
          description: mixedMultipleBackgroundDescription,
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Which one best describes your Mixed or Multiple ethnic group or background?';
local proxyTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Mixed or Multiple ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'mixed-or-multiple-ethnic-group',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidance, nonProxyDefinitionDescription, 'You can enter your ethnic group or background on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyGuidance, proxyDefinitionDescription, 'You can enter their ethnic group or background on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'other-mixed-or-multiple-ethnic-group',
        when: [
          {
            id: 'mixed-ethnic-group-answer',
            condition: 'equals',
            value: 'Any other Mixed or Multiple background',
          },
        ],
      },
    },
    {
      goto: {
        block: 'religion',
      },
    },
  ],
}
