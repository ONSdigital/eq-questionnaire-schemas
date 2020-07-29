local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'Question',
  id: 'other-uk-address',
  question: {
    id: 'other-uk-address-question',
    title: 'What is the other address?',
    type: 'General',
    answers: [
      {
        id: 'other-uk-address-answer-building',
        label: 'Address line 1',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'other-uk-address-answer-street',
        label: 'Address line 2',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'other-uk-address-answer-city',
        label: 'Town or city',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'other-uk-address-answer-postcode',
        label: 'Postcode',
        mandatory: false,
        type: 'TextField',
      },
    ],
  },
}
