local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'usual-address',
  question: {
    id: 'usual-address-question',
    title: 'What was your household’s usual address?',
    type: 'General',
    answers: [
      {
        id: 'usual-address-answer-building',
        label: 'Address line 1',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'usual-address-answer-street',
        label: 'Address line 2',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'usual-address-answer-city',
        label: 'Town or city',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'usual-address-answer-county',
        label: 'County',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'usual-address-answer-postcode',
        label: 'Postcode',
        mandatory: false,
        type: 'TextField',
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        block: 'anyone-else-list-collector',
      },
    },
  ],
}
