local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'other-address-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'other-address-uk-answer',
      mandatory: true,
      type: 'Address',
      lookup_options: {
        address_type: 'Residential',
        region_code: std.extVar('region_code'),
      },
    },
  ],
};

local nonProxyTitle = 'Enter details of the other UK address where you stay for more than 30 days a year.';
local proxyTitle = {
  text: 'Enter details of the other UK address where <em>{person_name}</em> stays for more than 30 days a year.',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'other-address-uk',
  page_title: 'Other UK address',
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
