local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'term-time-address-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'term-time-address-uk-answer',
      mandatory: true,
      type: 'Address',
      lookup_options: {
        address_type: 'Residential',
        region_code: std.extVar('region_code'),
      },
    },
  ],
};

local nonProxyTitle = 'Enter details of the UK address where you usually stay during term time.';
local proxyTitle = {
  text: 'Enter details of the UK address where <em>{person_name}</em> usually stays during term time.',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'term-time-address-uk',
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
        section: 'End',
      },
    },
  ],
}
