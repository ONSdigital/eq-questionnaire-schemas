local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local primaryEditPersonQuestionTitle = {
  text: 'Change details for <em>{person_name}</em> (You)',
  placeholders: [
    placeholders.personName,
  ],
};

local nonPrimaryEditPersonQuestionTitle = {
  text: 'Change details for <em>{person_name}</em>',
  placeholders: [
    placeholders.personName,
  ],
};

local editQuestion(questionTitle) = {
  id: 'any-more-people-living-here-edit-person-question',
  type: 'General',
  title: questionTitle,
  answers: [
    {
      id: 'first-name',
      label: 'First name',
      mandatory: true,
      type: 'TextField',
    },
    {
      id: 'middle-names',
      label: 'Middle names',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'last-name',
      label: 'Last name',
      mandatory: true,
      type: 'TextField',
    },
  ],
};


{
  id: 'any-more-people-living-here',
  type: 'ListCollector',
  for_list: 'household',
  add_answer: {
    id: 'any-more-people-living-here-answer',
    value: 'Yes',
  },
  remove_answer: {
    id: 'any-more-people-living-here-remove-person-confirmation',
    value: 'Yes',
  },
  question: {
    id: 'any-more-people-living-here-confirmation-question',
    type: 'General',
    title: 'Apart from the people already included, is there anyone else who was temporarily away or staying that you need to add?',
    instruction: ['Tell the respondent to double-check <strong>Showcard 2</strong> or show them the <strong>Electronic Showcard</strong> below'],
    definitions: [
      {
        title: 'Electronic Showcard',
        contents: [
          {
            description: '<strong>Include people temporarily away such as</strong>',
          },
          {
            list: [
              'people who worked away from home within the UK, or members of the armed forces, if this was their permanent or family home',
              'people staying or expecting to stay in an establishment such as a hospital, care home or hostel for <strong>less than 6 months</strong>, if this was their permanent or family home',
              'prisoners with a sentence of <strong>less than 12 months</strong>',
              'people who were temporarily outside the UK for <strong>less than 12 months</strong>',
              'other people who usually lived with your household, but were temporarily away, for example, at a second address for work or on holiday',
            ],
          },
          {
            description: '<strong>Include people temporarily staying such as</strong>',
          },
          {
            list: [
              'people staying temporarily who did not have another UK address, for example, UK residents between addresses or currently without a home',
              'people from outside the UK who were staying in the UK for <strong>3 months or more</strong>',
            ],
          },
        ],
      },
    ],
    answers: [
      {
        id: 'any-more-people-living-here-answer',
        mandatory: true,
        type: 'Radio',
        options: [
          {
            label: 'Yes',
            value: 'Yes',
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
    id: 'any-more-people-living-here-add-person',
    type: 'ListAddQuestion',
    question: {
      id: 'any-more-people-living-here-add-person-question',
      type: 'General',
      title: 'Who do you need to add?',
      instruction: ['Enter a full stop (.) if the respondent does not know a person’s “First name” or “Last name”'],
      answers: [
        {
          id: 'first-name',
          label: 'First name',
          mandatory: true,
          type: 'TextField',
        },
        {
          id: 'middle-names',
          label: 'Middle names',
          mandatory: false,
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
  edit_block: {
    id: 'any-more-people-living-here-edit-person',
    type: 'ListEditQuestion',
    question_variants: [
      {
        question: editQuestion(primaryEditPersonQuestionTitle),
        when: [rules.isPrimary],
      },
      {
        question: editQuestion(nonPrimaryEditPersonQuestionTitle),
        when: [rules.isNotPrimary],
      },
    ],
  },
  remove_block: {
    id: 'any-more-people-living-here-remove-person',
    type: 'ListRemoveQuestion',
    question: {
      id: 'any-more-people-living-here-remove-person-question',
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
          id: 'any-more-people-living-here-remove-person-confirmation',
          mandatory: true,
          type: 'Radio',
          options: [
            {
              label: 'Yes',
              value: 'Yes',
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
    title: 'Household members',
    item_title: {
      text: '{person_name}',
      placeholders: [
        placeholders.personName,
      ],
    },
  },
}
