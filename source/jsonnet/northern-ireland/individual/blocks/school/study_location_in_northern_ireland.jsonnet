local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'study-location-in-northern-ireland-question',
  type: 'General',
  title: title,
  answers: [
    {
      id: 'study-location-in-northern-ireland-answer',
      type: 'Address',
      lookup_options: {
        address_type: 'Educational',
        region_code: std.extVar('region_code'),
      },
    },
  ],
};

local nonProxyTitleSchool = 'What is the address of your main place of <em>study</em>?';
local proxyTitleSchool = {
  text: 'What is the address of <em>{person_name_possessive}</em> main place of <em>study</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

{
  type: 'Question',
  id: 'study-location-in-northern-ireland',
  page_title: 'Study address',
  question_variants: [
    {
      question: question(nonProxyTitleSchool),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitleSchool),
      when: [rules.isProxy],
    },
  ],
}
