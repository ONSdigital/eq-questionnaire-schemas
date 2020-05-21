local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyGuidance = 'Why your answer is important';
local proxyGuidance = 'Why their answer is important';

local nonProxyDefinitionDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDefinitionDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local question(title, guidance, definitionDescription, otherEthnicGroup) = {
  id: 'other-ethnic-group-question',
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
      id: 'other-ethnic-group-answer',
      mandatory: false,
      options: [
        {
          label: 'Arab',
          value: 'Arab',
        },
        {
          label: 'Any other ethnic group',
          value: 'Any other ethnic group',
          description: otherEthnicGroup,
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Which one best describes your other ethnic group or background?';
local proxyTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> other ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'other-ethnic-group',
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
        block: 'ethnic-group-other-other',
        when: [
          {
            id: 'other-ethnic-group-answer',
            condition: 'equals',
            value: 'Any other ethnic group',
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
