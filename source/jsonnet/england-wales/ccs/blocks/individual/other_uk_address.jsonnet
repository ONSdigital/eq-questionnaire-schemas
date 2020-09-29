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
        id: 'other-uk-address-answer',
        mandatory: false,
        type: 'Address',
        lookup_options: {
          address_type: 'Residential',
          region_code: std.extVar('region_code'),
        },
      },
    ],
  },
}
