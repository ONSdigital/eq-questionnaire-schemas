local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, questionDescription, answerDescription) = {
  id: 'employment-status-last-seven-days-question',
  title: title,
  type: 'MutuallyExclusive',
  description: [
    questionDescription,
  ],
  mandatory: true,
  guidance: {
    contents: [
      {
        description: 'Include casual or temporary work, even if only for one hour',
      },
    ],
  },
  answers: [
    {
      id: 'employment-status-last-seven-days-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'Working as an employee',
          value: 'Working as an employee',
        },
        {
          label: 'Self-employed or freelance',
          value: 'Self-employed or freelance',
          description: answerDescription,
        },
        {
          label: 'Temporarily away from work ill, on holiday or temporarily laid off',
          value: 'Temporarily away from work ill, on holiday or temporarily laid off',
        },
        {
          label: 'On maternity or paternity leave',
          value: 'On maternity or paternity leave',
        },
        {
          label: 'Doing any other kind of paid work',
          value: 'Doing any other kind of paid work',
        },
      ],
    },
    {
      id: 'employment-status-last-seven-days-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'None of these apply',
          value: 'None of these apply',
        },
      ],
    },
  ],
};

local nonProxyTitle = 'In the last seven days, were you doing any of the following?';
local proxyTitle = {
  text: 'In the last seven days, was <em>{person_name}</em> doing any of the following?',
  placeholders: [
    placeholders.personName(),
  ],
};

local nonProxyQuestionDescription = 'If you have a job but have been off work in <strong>quarantine</strong> or <strong>self-isolating</strong>, select “Temporarily away from work ill, on holiday or temporarily laid off”';
local proxyQuestionDescription = 'If they have a job but have been off work in  <strong>quarantine</strong> or  <strong>self-isolating </strong>, select “Temporarily away from work ill, on holiday or temporarily laid off”';

local nonProxyAnswerDescription = 'Freelance means that you are self-employed and work for different companies or people on particular pieces of work';
local proxyAnswerDescription = 'Freelance means that they are self-employed and work for different companies or people on particular pieces of work';

{
  type: 'Question',
  id: 'employment-status-last-seven-days',
  page_title: 'Employment status in the last seven days',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyQuestionDescription, nonProxyAnswerDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyQuestionDescription, proxyAnswerDescription),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'not-employed-status-last-seven-days',
        when: [
          rules.lastMainJob,
        ],
      },
    },
    {
      goto: {
        block: 'main-job-introduction',
      },
    },
  ],
}
