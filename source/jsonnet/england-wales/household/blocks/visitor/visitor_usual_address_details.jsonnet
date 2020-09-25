local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';


{
  type: 'Question',
  id: 'visitor-usual-address-details',
  page_title: 'Usual address details',
  question: {
    id: 'visitor-usual-address-details-question',
    title: {
      text: 'Enter details of <em>{person_name_possessive}</em> usual UK address',
      placeholders: [
        placeholders.personNamePossessive,
      ],
    },
    type: 'General',
    answers: [
      {
        id: 'visitor-usual-address-details-answer',
        mandatory: true,
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
