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
    title: questionTitle,
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
      title: addVisitorQuestionTitle,
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
      title: editPersonQuestionTitle,
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
      title: removePersonQuestionTitle,
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
    title: summaryTitle,
    item_title: summaryTitlePersonName,
  },
}
