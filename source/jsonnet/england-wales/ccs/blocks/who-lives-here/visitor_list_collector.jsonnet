local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle = {
  text: 'Were there any other visitors staying overnight on {census_date} at {household_address}?',
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
  for_list: 'visitor',
  add_answer: {
    id: 'visitor-answer',
    value: 'Yes',
  },
  remove_answer: {
    id: 'visitor-remove-confirmation',
    value: 'Yes',
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
    id: 'add-visitor',
    type: 'ListAddQuestion',
    cancel_text: 'Don’t need to add anyone?',
    question: {
      id: 'visitor-add-question',
      type: 'General',
      title: addVisitorQuestionTitle,
      instruction: 'Enter a full stop (.) if the respondent does not know a person’s “First name” or “Last name”',
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
    title: summaryTitle,
    item_title: summaryTitlePersonName,
    add_link_text: 'Add a visitor',
    empty_list_text: 'There are no visitors',
  },
  show_on_section_summary: true,
}
