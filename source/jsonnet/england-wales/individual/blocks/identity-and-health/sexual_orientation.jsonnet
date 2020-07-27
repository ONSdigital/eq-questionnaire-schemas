local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidanceHeader, description) = {
  id: 'sexual-orientation-question',
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
      id: 'sexual-orientation-answer',
      mandatory: false,
      voluntary: true,
      guidance: {
        show_guidance: guidanceHeader,
        hide_guidance: guidanceHeader,
        contents: [
          {
            description: description,
          },
          {
            description: 'Councils and government will use this information to',
            list: [
              'monitor equality to ensure that everyone is treated fairly',
              'provide services and share funding',
            ],
          },
        ],
      },
      options: [
        {
          label: 'Straight or Heterosexual',
          value: 'Straight or Heterosexual',
        },
        {
          label: 'Gay or Lesbian',
          value: 'Gay or Lesbian',
        },
        {
          label: 'Bisexual',
          value: 'Bisexual',
        },
        {
          label: 'Other sexual orientation',
          value: 'Other sexual orientation',
          detail_answer: {
            id: 'sexual-orientation-answer-other',
            max_length: 100,
            type: 'TextField',
            mandatory: false,
            label: 'Enter sexual orientation',
            visible: true,
          },
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Which of the following best describes your sexual orientation?';
local proxyTitle = {
  text: 'Which of the following best describes <em>{person_name_possessive}</em> sexual orientation?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local nonProxyGuidanceHeader = 'Why your answer is important';
local proxyGuidanceHeader = 'Why their answer is important';

local nonProxyDescription = 'Your answer will help your local community by providing organisations, such as charities, with an understanding of the services people might need.';
local proxyDescription = 'Their answer will help their local community by providing organisations, such as charities, with an understanding of the services people might need.';

{
  type: 'Question',
  id: 'sexual-orientation',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidanceHeader, nonProxyDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyGuidanceHeader, proxyDescription),
      when: [rules.isProxy],
    },
  ],
}
