local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  id: 'main-job-type-question',
  title: title,
  description: description,
  type: 'General',
  answers: [
    {
      id: 'main-job-type-answer',
      mandatory: false,
      options: [
        {
          label: 'Employee',
          value: 'Employee',
        },
        {
          label: 'Self-employed or freelance without employees',
          value: 'Self-employed or freelance without employees',
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

local nonProxyDescription = 'Your main job is the job in which you usually work the most hours';
local proxyDescription = 'Their main job is the job in which they usually work the most hours';
local pastNonProxyDescription = 'This is the most recent job you had. If you had more than one job at the same time, answer for the job in which you usually worked the most hours.';
local pastProxyDescription = 'This is the most recent job they had. If they had more than one job at the same time, answer for the job in which they usually worked the most hours.';

{
  type: 'Question',
  id: 'main-job-type',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDescription),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitle, proxyDescription),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitle, pastNonProxyDescription),
      when: [rules.isNotProxy, rules.lastMainJob],
    },
    {
      question: question(pastProxyTitle, pastProxyDescription),
      when: [rules.isProxy, rules.lastMainJob],
    },
  ],
}
