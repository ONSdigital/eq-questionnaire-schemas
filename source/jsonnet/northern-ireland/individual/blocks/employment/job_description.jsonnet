local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'job-description-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'job-description-answer',
      label: 'Job description',
      max_length: 120,
      mandatory: false,
      rows: 4,
      type: 'TextArea',
    },
  ],
};

local nonProxyTitle = 'Briefly describe what you do in your main job.';
local proxyTitle = {
  text: 'Briefly describe what <em>{person_name}</em> does in their main job.',
  placeholders: [
    placeholders.personName(),
  ],
};

local pastNonProxyTitle = 'Briefly describe what you did in your main job.';
local pastProxyTitle = {
  text: 'Briefly describe what <em>{person_name}</em> did in their main job.',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'job-description',
  page_title: 'Job description',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitle),
      when: [rules.isNotProxy, rules.lastMainJob],
    },
    {
      question: question(pastProxyTitle),
      when: [rules.isProxy, rules.lastMainJob],
    },
  ],
}
