local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is the main activity of your organisation, business or freelance work?';
local proxyTitle = {
  text: 'What is the main activity of <em>{person_name_possessive}</em> organisation, business or freelance work?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'What was the main activity of your organisation, business or freelance work?';
local pastProxyTitle = {
  text: 'What was the main activity of <em>{person_name_possessive}</em> organisation, business or freelance work?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local question(title) = (
  {
    id: 'business-type-question',
    title: title,
    description: [
      'For example, clothing retail, general hospital, primary education, food wholesale, civil service or local government.',
    ],
    type: 'General',
    answers: [
      {
        id: 'business-type-answer',
        label: 'Main activity',
        mandatory: false,
        max_length: 120,
        type: 'TextField',
      },
    ],
  }
);

{
  type: 'Question',
  id: 'business-type',
  page_title: 'Business type',
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
