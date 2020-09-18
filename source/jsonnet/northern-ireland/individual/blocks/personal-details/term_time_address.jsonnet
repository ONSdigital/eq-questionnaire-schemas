local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'term-time-address-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'term-time-address-answer-building',
      label: 'Address line 1',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'term-time-address-answer-street',
      label: 'Address line 2',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'term-time-address-answer-city',
      label: 'Town or city',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'term-time-address-answer-postcode',
      label: 'Postcode',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'Enter details of your term time address.';
local proxyTitle = 'Enter details of their term time address.';

{
  type: 'Question',
  id: 'term-time-address',
  page_title: 'Term-time address UK',
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
  routing_rules: [
    {
      goto: {
        group: 'identity-and-health-group',
      },
    },
  ],
}
