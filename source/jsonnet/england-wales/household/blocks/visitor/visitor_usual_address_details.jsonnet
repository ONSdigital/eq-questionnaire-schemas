local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';


{
  type: 'Question',
  id: 'visitor-usual-address-details',
  page_title: 'Usual address details',
  question: {
    id: 'visitor-usual-address-details-question',
    title: {
      text: 'What is <em>{person_name_possessive}</em> usual address in the UK?',
      placeholders: [
        placeholders.personNamePossessive,
      ],
    },
    type: 'General',
    answers: [
      {
        id: 'visitor-usual-address-details-answer',
        mandatory: false,
        type: 'Address',
        lookup_options: {
          address_type: 'Residential',
          region_code: std.extVar('region_code'),
        },
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
