local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'address-one-year-ago-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'address-one-year-ago-answer-building',
      label: 'Address line 1',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'address-one-year-ago-answer-street',
      label: 'Address line 2',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'address-one-year-ago-answer-city',
      label: 'Town or city',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'address-one-year-ago-answer-postcode',
      label: 'Postcode',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'Enter details of your address one year ago.';
local proxyTitle = {
  text: 'Enter details of <em>{person_name_possessive}</em> address one year ago.',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'address-one-year-ago',
  page_title: 'Address one year ago',
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
