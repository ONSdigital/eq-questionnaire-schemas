local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'term-time-address-country-outside-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'term-time-address-country-outside-uk-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions: { url: '{suggestions_url_root}/countries-of-birth.json' },
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'term-time-address-country-outside-uk',
  page_title: 'Term-time address outside UK',
  question_variants: [
    {
      question: question('During term time, in which country outside the UK do you usually live?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'During term time, in which country outside the UK does <em>{person_name}</em> usually live?',
        placeholders: [
          placeholders.personName(),
        ],
      }),
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
