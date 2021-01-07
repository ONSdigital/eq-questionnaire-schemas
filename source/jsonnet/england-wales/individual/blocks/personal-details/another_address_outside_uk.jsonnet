local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'another-address-outside-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'another-address-outside-uk-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: true,
      suggestions: { url: '{suggestions_url_root}/countries-of-birth.json' },
      type: 'TextField',
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a country',
        },
      },
    },
  ],
};

{
  type: 'Question',
  id: 'another-address-outside-uk',
  page_title: 'Other address outside the UK',
  question_variants: [
    {
      question: question('In which country outside the UK do you stay for more than 30 days a year?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'In which country outside the UK does <em>{person_name}</em> stay for more than 30 days a year?',
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
        block: 'address-type',
      },
    },
  ],
}
