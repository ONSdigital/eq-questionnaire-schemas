local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'mainly-work-outside-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'mainly-work-outside-uk-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'Which country outside of the UK do you mainly work in?';
local proxyTitle = {
  text: 'In which country outside the UK does <em>{person_name}</em> mainly work?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'mainly-work-outside-uk',
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
