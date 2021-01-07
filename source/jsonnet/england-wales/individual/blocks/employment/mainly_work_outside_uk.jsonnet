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
      suggestions: { url: '{suggestions_url_root}/countries-of-birth.json' },
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'In which country outside the UK do you mainly work?';
local proxyTitle = {
  text: 'In which country outside the UK does <em>{person_name}</em> mainly work?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'mainly-work-outside-uk',
  page_title: 'Mainly work outside the UK',
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
