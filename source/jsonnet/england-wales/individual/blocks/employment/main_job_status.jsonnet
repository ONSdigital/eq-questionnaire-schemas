local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, questionDescription, description) = {
  id: 'main-job-status-question',
  title: title,
  description: [
    questionDescription,
  ],
  type: 'General',
  answers: [
    {
      id: 'main-job-status-answer',
      mandatory: false,
      options: [
        {
          label: 'Employee',
          value: 'Employee',
        },
        {
          label: 'Self-employed or freelance without employees',
          value: 'Self-employed or freelance without employees',
          description: description,
        },
        {
          label: 'Self-employed with employees',
          value: 'Self-employed with employees',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'In your main job, what is your employment status?';
local proxyTitle = {
  text: 'In their main job, what is <em>{person_name_possessive}</em> employment status?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'In your main job, what was your employment status?';
local pastProxyTitle = {
  text: 'In their main job, what was <em>{person_name_possessive}</em> employment status?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local nonProxyQuestionDescription = 'Your main job is the job in which you usually work the most hours';
local proxyQuestionDescription = 'Their main job is the job in which they usually work the most hours';
local pastNonProxyQuestionDescription = 'This is the most recent job you had. If you had more than one job at the same time, answer for the job in which you usually worked the most hours.';
local pastProxyQuestionDescription = 'This is the most recent job they had. If they had more than one job at the same time, answer for the job in which they usually worked the most hours.';

local nonProxyAnswerDescription = 'Freelance means that you are self-employed and work for different companies or people on particular pieces of work';
local proxyAnswerDescription = 'Freelance means that they are self-employed and work for different companies or people on particular pieces of work';
local pastNonProxyAnswerDescription = 'Freelance means that you were self-employed and worked for different companies or people on particular pieces of work';
local pastProxyAnswerDescription = 'Freelance means that they were self-employed and worked for different companies or people on particular pieces of work';

{
  type: 'Question',
  id: 'main-job-status',
  page_title: 'Main job employment status',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyQuestionDescription, nonProxyAnswerDescription),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitle, proxyQuestionDescription, proxyAnswerDescription),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitle, pastNonProxyQuestionDescription, pastNonProxyAnswerDescription),
      when: [rules.isNotProxy, rules.lastMainJob],
    },
    {
      question: question(pastProxyTitle, pastProxyQuestionDescription, pastProxyAnswerDescription),
      when: [rules.isProxy, rules.lastMainJob],
    },
  ],
}
