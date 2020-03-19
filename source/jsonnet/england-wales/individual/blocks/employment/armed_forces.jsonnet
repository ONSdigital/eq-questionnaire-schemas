local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidanceHeader, guidanceContent) = {
  id: 'armed-forces-question',
  title: title,
  guidance: {
    contents: [
      {
        description: '<em>Current serving members</em> should only select “No”',
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
        show_guidance: guidanceHeader,
        hide_guidance: guidanceHeader,
        contents: guidanceContent,
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
local nonProxyGuidanceHeader = 'Why your answer is important';
local nonProxyGuidanceContent = [
  {
    description: 'Your answer will help your local community by providing information needed to support people who used to serve in the UK Armed Forces but have now left.',
  },
  {
    description: 'Councils and government will use this information to carry out the commitments they made under the Armed Forces Covenant. This is a promise by the nation to ensure that those who serve or who have served in the UK Armed Forces, and their families, are not disadvantaged.',
  },
];

local proxyTitle = {
  text: 'Has <em>{person_name}</em> previously served in the UK Armed Forces?',
  placeholders: [
    placeholders.personName,
  ],
};
local proxyGuidanceHeader = 'Why their answer is important';
local proxyGuidanceContent = [
  {
    description: 'Their answer will help their local community by providing information needed to support people who used to serve in the UK Armed Forces but have now left.',
  },
  {
    description: 'Councils and government will use this information to carry out the commitments they made under the Armed Forces Covenant. This is a promise by the nation to ensure that those who serve or who have served in the UK Armed Forces, and their families, are not disadvantaged.',
  },
];

{
  type: 'Question',
  id: 'armed-forces',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidanceHeader, nonProxyGuidanceContent),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyGuidanceHeader, proxyGuidanceContent),
      when: [rules.isProxy],
    },
  ],
}
