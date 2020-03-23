local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'other-ethnic-group-question',
  title: title,
  type: 'General',
  answers: [
    {
      guidance: {
        show_guidance: 'Why your answer is important',
        hide_guidance: 'Why your answer is important',
        contents: [
          {
            description: 'Your answer will help to support equality and fairness in your community. Councils and government use information on ethnic group to make sure they',
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
          description: 'You can enter their ethnic group or background on the next question',
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
