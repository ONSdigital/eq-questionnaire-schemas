local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  id: 'any-more-visitors',
  type: 'ListCollector',
  for_list: 'visitors',
  question: {
    id: 'visitor-confirmation-question',
    type: 'General',
    title: {
      text: 'Were there any other visitors staying overnight on Sunday {census_date}?',
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
            label: 'Yes',
            value: 'Yes',
            action: {
              type: 'RedirectToAddBlock',
            },
          },
          {
            label: 'No',
            value: 'No',
          },
        ],
      },
    ],
  },
  add_block: {
    id: 'add-visitor',
    type: 'ListAddQuestion',
    question_variants: [
      {
        question: {
          id: 'visitor-add-question',
          type: 'General',
          title: 'What is the name of the visitor who stayed overnight?',
          instruction: ['Enter a full stop (.) if the respondent does not know a person’s “First name” or “Last name”'],
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
        when: [
          {
            list: 'visitors',
            condition: 'equals',
            value: 0,
          },
        ],
      },
      {
        question: {
          id: 'visitor-add-question',
          type: 'General',
          title: {
            text: 'What is the name of the {ordinality} visitor who stayed overnight?',
            placeholders: [
              placeholders.getListOrdinalityWithoutDeterminer('visitors'),
            ],
          },
          instruction: ['Enter a full stop (.) if the respondent does not know a person’s “First name” or “Last name”'],
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
        when: [
          {
            list: 'visitors',
            condition: 'greater than',
            value: 0,
          },
        ],
      },
    ],
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
      warning: 'All of the information entered about this person will be deleted',
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
              label: 'Yes',
              value: 'Yes',
              action: {
                type: 'RedirectToRemoveBlock',
              },
            },
            {
              label: 'No',
              value: 'No',
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
