local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyDefinitionDescription = 'Your answer will provide a better understanding of your community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';
local proxyDefinitionDescription = 'Their answer will provide a better understanding of their community and help to support equality and fairness. For example, councils and government use information on ethnic group to make sure they';

local question(title, definitionDescription) = {
  id: 'black-ethnic-group-question',
  title: title,
  type: 'General',
  answers: [
    {
      guidance: {
        show_guidance: 'Why your answer is important',
        hide_guidance: 'Why your answer is important',
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
      id: 'black-ethnic-group-answer',
      mandatory: false,
      options: [
        {
          label: 'Caribbean',
          value: 'Caribbean',
        },
        {
          label: 'African',
          value: 'African',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'african-ethnic-group-answer-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter African background',
          },
        },
        {
          label: 'Any other Black, Black British or Caribbean background',
          value: 'Any other Black, Black British or Caribbean background',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'black-ethnic-group-answer-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter Black, Black British or Caribbean background',
          },
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Which one best describes your Black, Black British, Caribbean or African ethnic group or background?';
local proxyTitle = {
  text: 'Which one best describes <em>{person_name_possessive}</em> Black, Black British, Caribbean or African ethnic group or background?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'black-ethnic-group',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDefinitionDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyDefinitionDescription),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'religion',
      },
    },
  ],
}
