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
        id: 'usual-address-answer',
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
        block: 'anyone-else-driver',
      },
    },
  ],
}
