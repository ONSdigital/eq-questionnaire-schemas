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
  id: 'people-living-here-add-person-question',
  type: 'General',
  title: addQuestionTitle(listIsEmpty),
  answers: [
    {
      id: 'first-name',
      label: 'First name',
      mandatory: true,
      type: 'TextField',
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a first name',
        },
      },
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
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a last name',
        },
      },
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
  id: 'people-living-here-edit-person-question',
  type: 'General',
  title: questionTitle,
  answers: [
    {
      id: 'first-name',
      label: 'First name',
      mandatory: true,
      type: 'TextField',
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a first name',
        },
      },
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
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a last name',
        },
      },
    },
  ],
};

{
  id: 'people-living-here',
  type: 'ListCollector',
  for_list: 'household',
  question_variants: [
    {
      question: {
        type: 'General',
        id: 'people-living-here-question',
        title: questionTitle,
        answers: [
          {
            id: 'people-living-here-answer',
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
                action: {
                  type: 'AddAnswerForListItem',
                },
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
        id: 'people-living-here-question',
        type: 'General',
        title: {
          text: 'Does anyone else live at {household_address}?',
          placeholders: [
            placeholders.address,
          ],
        },
        answers: [
          {
            id: 'people-living-here-answer',
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
                action: {
                  type: 'AddAnswerForListItem',
                },
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
    id: 'people-living-here-add-person',
    type: 'ListAddQuestion',
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
    id: 'people-living-here-edit-person',
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
    id: 'people-living-here-remove-person',
    type: 'ListRemoveQuestion',
    question: {
      id: 'people-living-here-remove-person-question',
      type: 'General',
      title: {
        text: 'Are you sure you want to remove <em>{person_name}</em>?',
        placeholders: [
          placeholders.personName,
        ],
      },
      warning: 'All of the information entered about this person will be deleted',
      answers: [
        {
          id: 'people-living-here-remove-person-answer',
          mandatory: true,
          type: 'Radio',
          options: [
            {
              label: 'Yes, I want to remove this person',
              value: 'Yes, I want to remove this person',
              action: {
                type: 'RemoveAnswerForListItem',
              },
            },
            {
              label: 'No, I don‘t want to remove this person',
              value: 'No, I don‘t want to remove this person',
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
