local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local visitorGuidance = {
  contents: [
    {
      title: 'Include',
    },
    {
      list: [
        'People who usually live somewhere else in the UK, for example boy/girlfriends, friends or relatives',
        'People staying here because it is their second address, for example, for work. Their permanent or family home is elsewhere',
        'People who usually live outside the UK who are staying in the UK for less than three months',
        'People here on holiday',
      ],
    },
  ],
};

{
  id: 'visitor-list-collector',
  type: 'ListCollector',
  for_list: 'visitors',
  add_answer: {
    id: 'visitor-answer',
    value: 'Yes, I need to add someone',
  },
  remove_answer: {
    id: 'visitor-remove-confirmation',
    value: 'Yes, I want to remove this person',
  },
  question: {
    id: 'visitor-confirmation-question',
    type: 'General',
    title: {
      text: 'Are there any other visitors staying overnight on {census_date} at {household_address}?',
      placeholders: [
        placeholders.censusDate,
        placeholders.address,
      ],
    },
    guidance: visitorGuidance,
    answers: [
      {
        id: 'visitor-answer',
        mandatory: true,
        type: 'Radio',
        options: [
          {
            label: 'Yes, I need to add someone',
            value: 'Yes, I need to add someone',
          },
          {
            label: 'No, I do not need to add anyone',
            value: 'No, I do not need to add anyone',
          },
        ],
      },
    ],
  },
  add_block: {
    id: 'add-visitor',
    type: 'ListAddQuestion',
    cancel_text: 'Don’t need to add anyone?',
    question: {
      id: 'visitor-add-question',
      type: 'General',
      title: {
        text: 'What is the name of the visitor staying overnight on {census_date} at {household_address}?',
        placeholders: [
          placeholders.censusDate,
          placeholders.address,
        ],
      },
      guidance: visitorGuidance,
      answers: [
        {
          id: 'first-name',
          label: 'First name',
          mandatory: true,
          type: 'TextField',
        },
        {
          id: 'last-name',
          label: 'Last name',
          mandatory: true,
          type: 'TextField',
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
      ],
    },
  },
  edit_block: {
    id: 'edit-visitor',
    type: 'ListEditQuestion',
    question: {
      id: 'visitor-edit-question',
      type: 'General',
      title: {
        text: 'Change details for {person_name}',
        placeholders: [
          placeholders.personName,
        ],
      },
      answers: [
        {
          id: 'first-name',
          label: 'First name',
          mandatory: true,
          type: 'TextField',
        },
        {
          id: 'last-name',
          label: 'Last name',
          mandatory: true,
          type: 'TextField',
        },
      ],
    },
  },
  remove_block: {
    id: 'remove-visitor',
    type: 'ListRemoveQuestion',
    question: {
      id: 'visitor-remove-question',
      type: 'General',
      guidance: {
        contents: [{
          title: 'All of the data entered about this person will be deleted',
        }],
      },
      title: {
        text: 'Are you sure you want to remove {person_name}?',
        placeholders: [
          placeholders.personName,
        ],
      },
      answers: [
        {
          id: 'visitor-remove-confirmation',
          mandatory: true,
          type: 'Radio',
          options: [
            {
              label: 'Yes, I want to remove this person',
              value: 'Yes, I want to remove this person',
            },
            {
              label: 'No, I do not want to remove this person',
              value: 'No, I do not want to remove this person',
            },
          ],
        },
      ],
    },
  },
  summary: {
    title: {
      text: 'Visitors staying overnight on {census_date}',
      placeholders: [
        placeholders.censusDate,
      ],
    },
    item_title: {
      text: '{person_name}',
      placeholders: [
        placeholders.personName,
      ],
    },
  },
}
