local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle = {
  text: 'Does anyone usually live at {household_address}?',
  placeholders: [
    placeholders.address,
  ],
};

local addQuestionTitle(listIsEmpty) = (
  if listIsEmpty then {
    text: 'Who lives at {household_address}?',
    placeholders: [
      placeholders.address,
    ],
  } else {
    text: 'Who else lives at {household_address}?',
    placeholders: [
      placeholders.address,
    ],
  }
);

local addQuestion(listIsEmpty) = {
  id: 'add-question',
  type: 'General',
  title: addQuestionTitle(listIsEmpty),
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
  id: 'edit-question',
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
  id: 'anyone-else-list-collector',
  type: 'ListCollector',
  for_list: 'household',
  add_answer: {
    id: 'anyone-else-answer',
    value: 'Yes, I want to add {ordinality} person',
  },
  remove_answer: {
    id: 'remove-confirmation',
    value: 'Yes, I want to remove this person',
  },
  question_variants: [
    {
      question: {
        type: 'General',
        id: 'anyone-usually-live-at-question',
        title: questionTitle,
        answers: [
          {
            id: 'anyone-else-answer',
            mandatory: true,
            type: 'Radio',
            options: [
              {
                label: {
                  text: 'Yes, I want to add {ordinality} person',
                  placeholders: [
                    placeholders.getListOrdinality('household'),
                  ],
                },
                value: 'Yes, I want to add {ordinality} person',
              },
              {
                label: 'No, no one usually lives here',
                value: 'No, no one usually lives here',
                description: 'For example, this is a second address or holiday home',
              },
            ],
          },
        ],
      },
      when: [rules.listIsEmpty('household')],
    },
    {
      question: {
        id: 'anyone-usually-live-at-question',
        type: 'General',
        title: {
          text: 'Does anyone else live at {household_address}?',
          placeholders: [
            placeholders.address,
          ],
        },
        answers: [
          {
            id: 'anyone-else-answer',
            mandatory: true,
            type: 'Radio',
            options: [
              {
                label: {
                  text: 'Yes, I want to add {ordinality} person',
                  placeholders: [
                    placeholders.getListOrdinality('household'),
                  ],
                },
                value: 'Yes, I want to add {ordinality} person',
              },
              {
                label: 'No, I do not need to add anyone',
                value: 'No, I do not need to add anyone',
              },
            ],
          },
        ],
      },
      when: [rules.listIsNotEmpty('household')],
    },
  ],
  add_block: {
    id: 'add-person',
    type: 'ListAddQuestion',
    cancel_text: 'Don’t need to add anyone?',
    question_variants: [
      {
        question: addQuestion(listIsEmpty=false),
        when: [rules.listIsNotEmpty('household')],
      },
      {
        question: addQuestion(listIsEmpty=true),
        when: [rules.listIsEmpty('household')],
      },
    ],
  },
  edit_block: {
    id: 'edit-person',
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
    id: 'remove-person',
    type: 'ListRemoveQuestion',
    question: {
      id: 'remove-question',
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
          id: 'remove-confirmation',
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
