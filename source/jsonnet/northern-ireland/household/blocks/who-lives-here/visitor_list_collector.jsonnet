local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle = {
  text: 'Are there any other visitors staying overnight on {census_date} at {household_address}?',
  placeholders: [
    placeholders.censusDate,
    placeholders.address,
  ],
};

local summaryTitle = {
  text: 'Visitors staying overnight on {census_date}',
  placeholders: [
    placeholders.censusDate,
  ],
};

local summaryTitlePersonName = {
  text: '{person_name}',
  placeholders: [
    placeholders.personName,
  ],
};

local addVisitorQuestionTitle = {
  text: 'What is the name of the visitor staying overnight on {census_date} at {household_address}?',
  placeholders: [
    placeholders.censusDate,
    placeholders.address,
  ],
};

local editPersonQuestionTitle = {
  text: 'Change details for {person_name}',
  placeholders: [
    placeholders.personName,
  ],
};

local removePersonQuestionTitle = {
  text: 'Are you sure you want to remove {person_name}?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  id: 'visitor-list-collector',
  type: 'ListCollector',
  for_list: 'visitors',
  question: {
    id: 'visitor-confirmation-question',
    type: 'General',
    title: questionTitle,
    answers: [
      {
        id: 'visitor-answer',
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
            action: {
              type: 'RedirectToAddBlock',
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
  add_block: {
    id: 'add-visitor',
    type: 'ListAddQuestion',
    question: {
      id: 'visitor-add-question',
      type: 'General',
      title: addVisitorQuestionTitle,
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
          id: 'last-name',
          label: 'Last name',
          mandatory: true,
          type: 'TextField',
          guidance: {
            show_guidance: 'Why we ask about visitors',
            hide_guidance: 'Why we ask about visitors',
            contents: [
              {
                description: 'This is to ensure that everyone is counted in the census. Add any visitors, even if they have been included on a census questionnaire at another address.',
              },
            ],
          },
          validation: {
            messages: {
              MANDATORY_TEXTFIELD: 'Enter a last name',
            },
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
      title: editPersonQuestionTitle,
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
    },
  },
  remove_block: {
    id: 'remove-visitor',
    type: 'ListRemoveQuestion',
    question: {
      id: 'visitor-remove-question',
      type: 'General',
      title: removePersonQuestionTitle,
      warning: 'All of the information entered about this person will be deleted',
      answers: [
        {
          id: 'visitor-remove-confirmation',
          mandatory: true,
          type: 'Radio',
          options: [
            {
              label: 'Yes, I want to remove this person',
              value: 'Yes, I want to remove this person',
              action: {
                type: 'RedirectToRemoveBlock',
              },
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
    title: summaryTitle,
    item_title: summaryTitlePersonName,
  },
}
