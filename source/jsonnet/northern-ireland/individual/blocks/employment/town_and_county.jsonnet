local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'work-town-and-county-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'work-town-and-county-answer-town',
      label: 'Town or city',
      mandatory: false,
      max_length: 100,
      type: 'TextField',
    },
    {
      id: 'work-town-and-county-answer-county',
      label: 'County',
      mandatory: false,
      max_length: 100,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'In which town and county is your main place of work?';
local proxyTitle = {
  text: 'In which town and county is <em>{person_name_possessive}</em> main place of work?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'In which town and county was your main place of work?';
local pastProxyTitle = {
  text: 'In which town and county was <em>{person_name_possessive}</em> main place of work?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'work-town-and-county',
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