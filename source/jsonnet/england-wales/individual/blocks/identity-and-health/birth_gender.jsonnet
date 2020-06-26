local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'birth-gender-question',
  title: title,
  type: 'General',
  guidance: {
    contents: [
      {
        description: 'This question is <strong>voluntary</strong>',
      },
    ],
  },
  answers: [
    {
      id: 'birth-gender-answer',
      mandatory: false,
      voluntary: true,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No',
          value: 'No',
          detail_answer: {
            id: 'birth-gender-answer-other',
            max_length: 100,
            type: 'TextField',
            mandatory: false,
            label: 'Enter gender identity',
            visible: true,
          },
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Is the gender you identify with the same as your sex registered at birth?';
local proxyTitle = {
  text: 'Is the gender <em>{person_name}</em> identifies with the same as their sex registered at birth?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'birth-gender',
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
}
