local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'address-one-year-ago-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'address-one-year-ago-answer',
      mandatory: true,
      type: 'Address',
      lookup_options: {
        address_type: 'Residential',
        one_year_ago: true,
        region_code: std.extVar('region_code'),
      },
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
