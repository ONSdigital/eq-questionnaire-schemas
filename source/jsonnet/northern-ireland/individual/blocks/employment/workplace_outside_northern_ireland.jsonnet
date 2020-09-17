local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'workplace-outside-northern-ireland-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'workplace-outside-northern-ireland-answer-town',
      label: 'Town or city',
      mandatory: false,
      max_length: 100,
      type: 'TextField',
    },
    {
      id: 'workplace-outside-northern-ireland-answer-county',
      label: 'County',
      mandatory: false,
      max_length: 100,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'In which town and county is your main place of <em>work</em>?';
local proxyTitle = {
  text: 'In which town and county is <em>{person_name_possessive}</em> main place of <em>work</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitle = 'In which town and county was your main place of <em>work</em>?';
local pastProxyTitle = {
  text: 'In which town and county was <em>{person_name_possessive}</em> main place of <em>work</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'workplace-outside-northern-ireland',
  page_title: 'Main place of work town and county',
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
        block: 'travel-to-work',
      },
    },
  ],
}
