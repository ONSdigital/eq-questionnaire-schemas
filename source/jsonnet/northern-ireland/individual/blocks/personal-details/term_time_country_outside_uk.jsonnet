local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'term-time-country-outside-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'term-time-country-outside-uk-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      suggestions_url: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v2.0.0/ni/countries-of-birth.json',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'term-time-country-outside-uk',
  question_variants: [
    {
      question: question('During term time, in which country outside the UK do you usually live?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'During term time, in which country outside the UK does <em>{person_name}</em> usually live?',
        placeholders: [
          placeholders.personName,
        ],
      }),
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
