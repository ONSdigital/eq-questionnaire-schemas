local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle = {
  text: 'Apart from everyone already included, who else is staying overnight on Sunday {census_date} at {household_address}?',
  placeholders: [
    placeholders.censusDate,
    placeholders.address,
  ],
};

local exclusiveAnswerText = {
  text: 'There are no visitors staying here overnight on {census_date}',
  placeholders: [
    placeholders.censusDate,
  ],
};

{
  type: 'ListCollectorDrivingQuestion',
  for_list: 'visitors',
  id: 'any-visitors',
  page_title: 'Visitors staying here',
  question: {
    type: 'MutuallyExclusive',
    id: 'any-visitors-question',
    title: questionTitle,
    description: ['These people will be counted as visitors'],
    mandatory: true,
    answers: [
      {
        id: 'any-visitors-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'People who usually live somewhere else in the UK, for example, boyfriends, girlfriends, friends or relatives',
            value: 'People who usually live somewhere else in the UK, for example, boyfriends, girlfriends, friends or relatives',
            action: {
              type: 'RedirectToListAddBlock',
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
              type: 'RedirectToListAddBlock',
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
              type: 'RedirectToListAddBlock',
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
              type: 'RedirectToListAddBlock',
              params: {
                block_id: 'add-visitor',
                list_name: 'visitors',
              },
            },
          },
        ],
        guidance: {
          show_guidance: 'Why we ask about visitors',
          hide_guidance: 'Why we ask about visitors',
          contents: [
            {
              description: 'This is to ensure that everyone is counted in the census. Add any visitors, even if they have been included on a census questionnaire at another address.',
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
            label: exclusiveAnswerText,
            value: 'There are no visitors staying here overnight on {census_date}',
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
        block: 'any-more-visitors',
      },
    },
  ],
}
