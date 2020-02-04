local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'armed-forces-question',
  title: title,
  guidance: {
    contents: [
      {
        description: 'Current serving members should only select “No”',
      },
    ],
  },
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'armed-forces-answer',
      mandatory: false,
      type: 'Checkbox',
      guidance: {
        show_guidance: 'Why your answer is important',
        hide_guidance: 'Why your answer is important',
        contents: [
          {
            description: 'Your answer will help your local community by providing information needed to support people who used to serve in the UK Armed Forces but have left.',
          },
          {
            description: 'Councils and government will use this information to carry out the commitments they made under the Armed Forces Covenant. This is a promise by the nation ensuring that those who serve or who have served in the UK Armed Forces, and their families, are not disadvantaged.',
          },
        ],
      },
      options: [
        {
          label: 'Yes, previously served in Regular Armed Forces',
          value: 'Yes, previously served in Regular Armed Forces',
        },
        {
          label: 'Yes, previously served in Reserve Armed Forces',
          value: 'Yes, previously served in Reserve Armed Forces',
        },
      ],
    },
    {
      id: 'armed-forces-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'No',
          value: 'No',
        },
      ],
    },
  ],
};

local nonProxyTitle = 'Have you previously served in the UK Armed Forces?';
local proxyTitle = {
  text: 'Has <em>{person_name}</em> previously served in the UK Armed Forces?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'armed-forces',
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
