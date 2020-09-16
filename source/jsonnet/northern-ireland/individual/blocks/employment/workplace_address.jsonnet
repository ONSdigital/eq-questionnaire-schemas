local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'workplace-address-question',
  type: 'General',
  title: title,
  answers: [
    {
      id: 'workplace-address-details-answer-building',
      label: 'Address line 1',
      mandatory: true,
      type: 'TextField',
    },
    {
      id: 'workplace-address-details-answer-street',
      label: 'Address line 2',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'workplace-address-details-answer-city',
      label: 'Town or city',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'workplace-address-details-answer-postcode',
      label: 'Postcode',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitleWork = 'What is the address of your main place of <em>work</em>?';
local proxyTitleWork = {
  text: 'What is the address of <em>{person_name_possessive}</em> main place of <em>work</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitleWork = 'What was the address of your main place of <em>work</em>?';
local pastProxyTitleWork = {
  text: 'What was the address of <em>{person_name_possessive}</em> main place of <em>work</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};


{
  type: 'Question',
  id: 'workplace-address',
  page_title: 'Workplace address',
  question_variants: [
    {
      question: question(nonProxyTitleWork),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitleWork),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitleWork),
      when: [rules.isNotProxy],
    },
    {
      question: question(pastProxyTitleWork),
      when: [rules.isProxy],
    },
  ],
}
