local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';


{
  type: 'Question',
  id: 'visitor-usual-address-country',
  page_title: 'Usual address country',
  question: {
    id: 'visitor-usual-address-country-question',
    title: {
      text: 'In which country outside the UK does <em>{person_name}</em> usually live?',
      placeholders: [
        placeholders.personName(),
      ],
    },
    type: 'General',
    answers: [
      {
        id: 'visitor-usual-address-country-answer',
        label: 'Current name of country',
        description: 'Enter your own answer or select from suggestions',
        mandatory: false,
        suggestions: { url: '{suggestions_url_root}/countries-of-birth.json' },
        type: 'TextField',
        max_length: 100,
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        section: 'End',
      },
    },
  ],
}
