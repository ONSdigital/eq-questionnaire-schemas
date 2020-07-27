local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'other-address-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'other-address-uk-answer-building',
      label: 'Address line 1',
      mandatory: true,
      type: 'TextField',
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter an address to continue',
        },
      },
    },
    {
      id: 'other-address-uk-answer-street',
      label: 'Address line 2',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'other-address-uk-answer-city',
      label: 'Town or city',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'other-address-uk-answer-postcode',
      label: 'Postcode',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'Enter details of the other UK address where you stay for more than 30 days a year.';
local proxyTitle = {
  text: 'Enter details of the other UK address where <em>{person_name}</em> stays for more than 30 days a year.',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'other-address-uk',
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
