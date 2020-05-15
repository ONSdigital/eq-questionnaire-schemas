local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'place-of-work-elsewhere-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'place-of-work-elsewhere-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'In which country is your main place of work?';
local proxyTitle = {
  text: 'In which country is <em>{person_name_possessive}</em> main place of work?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'In which country was your main place of work?';
local pastProxyTitle = {
  text: 'In which country was <em>{person_name_possessive}</em> main place of work?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'place-of-work-elsewhere',
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
      when: [rules.isNotProxy],
    },
    {
      question: question(pastProxyTitle),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'work-travel',
      },
    },
  ],
}