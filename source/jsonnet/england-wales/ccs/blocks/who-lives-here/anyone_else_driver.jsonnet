local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'ListCollectorDrivingQuestion',
  for_list: 'household',
  id: 'anyone-else-driver',
  question: {
    id: 'anyone-else-driver-question',
    title: {
      text: 'I will now collect the names of everyone who lived at that address on Sunday {census_date}',
      placeholders: [
        placeholders.censusDate,
      ],
    },
    type: 'General',
    answers: [
      {
        id: 'anyone-else-driver-answer',
        mandatory: true,
        options: [
          {
            label: 'OK, understood',
            value: 'OK, understood',
            action: {
              type: 'RedirectToListAddBlock',
              params: {
                block_id: 'add-person',
                list_name: 'household',
              },
            },
          },
        ],
        type: 'Checkbox',
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        block: 'who-else-lives-here',
      },
    },
  ],
}
