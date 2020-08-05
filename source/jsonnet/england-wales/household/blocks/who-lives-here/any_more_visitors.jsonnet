local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local addQuestionTitle(visitorsListEmpty) = (
  if visitorsListEmpty then {
    text: 'What is the name of the visitor staying overnight on Sunday {census_date} at {household_address}?',
    placeholders: [
      placeholders.censusDate,
      placeholders.address,
    ],
  } else {
    text: 'What is the name of the {ordinality} visitor staying overnight on Sunday {census_date} at {household_address}?',
    placeholders: [
      placeholders.censusDate,
      placeholders.address,
      placeholders.getListOrdinalityWithoutDeterminer('visitors'),
    ],
  }
);

local addQuestion(visitorsListEmpty) = {
  id: 'any-more-visitors-add-visitor-question',
  type: 'General',
  title: addQuestionTitle(visitorsListEmpty),
  answers: [
    {
      id: 'first-name',
      label: 'First name',
      mandatory: true,
      type: 'TextField',
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a first name to continue',
        },
      },
    },
    {
      id: 'last-name',
      label: 'Last name',
      mandatory: true,
      type: 'TextField',
      validation: {
        messages: {
          MANDATORY_TEXTFIELD: 'Enter a last name to continue',
        },
      },
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
  ],
};

{
  id: 'any-more-visitors',
  type: 'ListCollector',
  for_list: 'visitors',
  add_answer: {
    id: 'any-more-visitors-answer',
    value: 'Yes, I need to add {ordinality} visitor',
  },
  remove_answer: {
    id: 'any-more-visitors-remove-visitor-answer',
    value: 'Yes, I want to remove this person',
  },
  question: {
    id: 'any-more-visitors-question',
    type: 'General',
    title: {
      text: 'Are there any other visitors staying overnight on Sunday {census_date} at {household_address}?',
      placeholders: [
        placeholders.censusDate,
        placeholders.address,
      ],
    },
    answers: [
      {
        id: 'any-more-visitors-answer',
        mandatory: true,
        type: 'Radio',
        options: [
          {
            label: {
              text: 'Yes, I need to add {ordinality} visitor',
              placeholders: [
                placeholders.getListOrdinality('visitors'),
              ],
            },
            value: 'Yes, I need to add {ordinality} visitor',
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
    id: 'any-more-visitors-add-visitor',
    type: 'ListAddQuestion',
    question_variants: [
      {
        question: addQuestion(visitorsListEmpty=true),
        when: [{
          list: 'visitors',
          condition: 'equals',
          value: 0,
        }],
      },
      {
        question: addQuestion(visitorsListEmpty=false),
        when: [{
          list: 'visitors',
          condition: 'greater than',
          value: 0,
        }],
      },
    ],
  },
  edit_block: {
    id: 'any-more-visitors-edit-visitor',
    type: 'ListEditQuestion',
    question: {
      id: 'any-more-visitors-edit-visitor-question',
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
          validation: {
            messages: {
              MANDATORY_TEXTFIELD: 'Enter a first name to continue',
            },
          },
        },
        {
          id: 'last-name',
          label: 'Last name',
          mandatory: true,
          type: 'TextField',
          validation: {
            messages: {
              MANDATORY_TEXTFIELD: 'Enter a last name to continue',
            },
          },
        },
      ],
    },
  },
  remove_block: {
    id: 'any-more-visitors-remove-visitor',
    type: 'ListRemoveQuestion',
    question: {
      id: 'any-more-visitors-remove-visitor-question',
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
          id: 'any-more-visitors-remove-visitor-answer',
          mandatory: true,
          type: 'Radio',
          options: [
            {
              label: 'Yes, I want to remove this person',
              value: 'Yes, I want to remove this person',
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
