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
  id: 'anyone-else-temp-away-edit-question',
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
  id: 'anyone-else-temp-away-list-collector',
  type: 'ListCollector',
  for_list: 'household',
  add_answer: {
    id: 'anyone-else-temp-away-answer',
    value: 'Yes',
  },
  remove_answer: {
    id: 'anyone-else-temp-away-remove-confirmation',
    value: 'Yes, I want to remove this person',
  },
  question: {
    id: 'anyone-else-temp-away-confirmation-question',
    type: 'General',
    title: 'Apart from the people already included, is there anyone else who was temporarily away or staying that you need to add?',
    instruction: 'Tell the respondent to double-check <strong>Showcard 2</strong> or show them the <strong>Electronic Showcard</strong> below',
    definitions: [
      {
        title: 'Electronic Showcard',
        contents: [
          {
            description: 'Include people temporarily away such as',
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
            description: 'Include people temporarily staying on such as',
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
        id: 'anyone-else-temp-away-answer',
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
    id: 'anyone-else-temp-away-add-person',
    type: 'ListAddQuestion',
    question: {
      id: 'anyone-else-temp-away-add-question',
      type: 'General',
      title: 'Who do you need to add?',
      instruction: 'Enter a full stop (.) if the respondent does not know a person’s “First name” or “Last name”',
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
    id: 'anyone-else-temp-away-edit-person',
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
    id: 'anyone-else-temp-away-remove-person',
    type: 'ListRemoveQuestion',
    question: {
      id: 'anyone-else-temp-away-remove-question',
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
          id: 'anyone-else-temp-away-remove-confirmation',
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
    title: 'Household members',
    item_title: {
      text: '{person_name}',
      placeholders: [
        placeholders.personName,
      ],
    },
  },
}
