local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

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
    value: 'Yes, remove this person',
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
            show_guidance: 'Why we ask about visitors?',
            hide_guidance: 'Why we ask about visitors?',
            contents: [
              {
                description: 'This is to ensure that everyone is counted in the census. Add any visitors, even if they have been included on a census questionnaire at another address.',
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
        text: 'Change details for <em>{person_name}</em>',
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
        text: 'Are you sure you want to remove <em>{person_name}</em>?',
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
              label: 'Yes, remove this person',
              value: 'Yes, remove this person',
            },
            {
              label: 'No, cancel and return',
              value: 'No, cancel and return',
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
