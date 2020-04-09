local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';


{
  type: 'Question',
  id: 'usual-household-address-other',
  question: {
    id: 'usual-household-address-other-question',
    title: {
      text: 'In which country outside the UK does <em>{person_name}</em> usually live?',
      placeholders: [
        placeholders.personName,
      ],
    },
    type: 'General',

    answers: [
      {
        id: 'usual-household-address-other-answer',
        label: 'Current name of country',
        description: 'Enter your own answer or select from suggestions',
        mandatory: false,
        suggestions_url: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v1.0.0/countries-of-birth.json',
        type: 'TextField',
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        group: 'visitor-submit-group',
      },
    },
  ],
}
