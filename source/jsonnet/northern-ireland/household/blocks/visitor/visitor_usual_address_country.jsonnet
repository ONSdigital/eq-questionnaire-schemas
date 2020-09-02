local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local listName = 'countries-of-birth.json';

local suggestionsUrl = {
  text: '{suggestions_url}',
  placeholders: [placeholders.suggestionsUrl(listName)],
};

{
  type: 'Question',
  id: 'visitor-usual-address-country',
  question: {
    id: 'visitor-usual-address-country-question',
    title: {
      text: 'In which country outside the UK does <em>{person_name}</em> usually live?',
      placeholders: [
        placeholders.personName,
      ],
    },
    type: 'General',
    answers: [
      {
        id: 'visitor-usual-address-country-answer',
        label: 'Current name of country',
        description: 'Enter your own answer or select from suggestions',
        mandatory: false,
        suggestions_url: suggestionsUrl,
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
