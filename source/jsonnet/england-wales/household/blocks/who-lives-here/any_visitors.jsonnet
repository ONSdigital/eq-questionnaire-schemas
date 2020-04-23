local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'ListCollectorDrivingQuestion',
  for_list: 'visitors',
  id: 'any-visitors',
  question: {
    type: 'MutuallyExclusive',
    id: 'any-visitors-question',
    title: {
      text: 'Are there any visitors staying overnight on {census_date} at {household_address}?',
      placeholders: [
        placeholders.censusDate,
        placeholders.address,
      ],
    },
    mandatory: true,
    answers: [
      {
        id: 'any-visitors-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'People who usually live somewhere else in the UK, for example boy/girlfriends, friends or relatives',
            value: 'People who usually live somewhere else in the UK, for example boy/girlfriends, friends or relatives',
            action: {
              type: 'RedirectToListAddQuestion',
              params: {
                block_id: 'add-visitor',
                list_name: 'visitors',
              },
            },
          },
          {
            label: 'People staying here because it is their second address, for example, for work. Their permanent or family home is elsewhere',
            value: 'People staying here because it is their second address, for example, for work. Their permanent or family home is elsewhere',
            action: {
              type: 'RedirectToListAddQuestion',
              params: {
                block_id: 'add-visitor',
                list_name: 'visitors',
              },
            },
          },
          {
            label: 'People who usually live outside the UK who are staying in the UK for less than three months',
            value: 'People who usually live outside the UK who are staying in the UK for less than three months',
            action: {
              type: 'RedirectToListAddQuestion',
              params: {
                block_id: 'add-visitor',
                list_name: 'visitors',
              },
            },
          },
          {
            label: 'People here on holiday',
            value: 'People here on holiday',
            action: {
              type: 'RedirectToListAddQuestion',
              params: {
                block_id: 'add-visitor',
                list_name: 'visitors',
              },
            },
          },
        ],
        guidance: {
          show_guidance: 'Why do I have to include visitors?',
          hide_guidance: 'Why do I have to include visitors?',
          contents: [
            {
              description: 'We ask for visitor information to ensure that everyone is counted. This helps to produce accurate population estimates. Add any visitors, even if you think they may have been included on a census form at another address.',
            },
          ],
        },
      },
      {
        id: 'any-visitors-answer-exclusive',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: {
              text: 'No, there are no visitors staying overnight on {census_date}',
              placeholders: [
                placeholders.censusDate,
              ],
            },
            value: 'No, there are no visitors staying overnight on {census_date}',
          },
        ],
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        section: 'End',
        when: [{
          id: 'any-visitors-answer-exclusive',
          condition: 'set',
        }],
      },
    },
    {
      goto: {
        block: 'visitor-list-collector',
      },
    },
  ],
}
