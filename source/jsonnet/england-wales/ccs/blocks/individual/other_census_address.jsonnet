local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'Question',
  id: 'other-census-address',
  question: {
    id: 'other-census-address-question',
    title: 'What is the other address?',
    type: 'General',
    answers: [
      {
        id: 'other-census-address-answer-building',
        label: 'Address line 1',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'other-census-address-answer-street',
        label: 'Address line 2',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'other-census-address-answer-city',
        label: 'Town or city',
        mandatory: false,
        type: 'TextField',
      },
      {
        id: 'other-census-address-answer-postcode',
        label: 'Postcode',
        mandatory: false,
        type: 'TextField',
      },
    ],
  },
}
