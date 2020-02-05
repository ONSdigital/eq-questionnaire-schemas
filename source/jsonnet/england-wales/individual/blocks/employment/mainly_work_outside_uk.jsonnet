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
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'Which country outside of the UK do you mainly work in?';
local proxyTitle = {
  text: 'Which country outside of the UK does <em>{person_name}</em> mainly work in?',
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
