local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';


local questionTitle = {
  text_plural: {
    forms: {
      one: 'You said {cardinal} person lives at {household_address}. Do you need to add anyone?',
      other: 'You said {cardinal} people live at {household_address}. Do you need to add anyone?',
    },
    count: {
      source: 'list',
      identifier: 'household',
    },
  },
  placeholders: [
    placeholders.address,
    placeholders.cardinal,
  ],
};

local summaryTitlePersonName = {
  text: '{person_name}',
  placeholders: [
    placeholders.personName,
  ],
};

local addPersonQuestionTitle = {
  text: 'Who do you need to add to {household_address}?',
  placeholders: [
    placeholders.address,
  ],
};

local primaryEditPersonQuestionTitle = {
  text: 'Change details for {person_name} (You)',
  placeholders: [
    placeholders.personName,
  ],
};

local nonPrimaryEditPersonQuestionTitle = {
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
    value: 'Yes, I need to add someone',
  },
  remove_answer: {
    id: 'anyone-else-temp-away-remove-confirmation',
    value: 'Yes, I want to remove this person',
  },
  question: {
    id: 'anyone-else-temp-away-confirmation-question',
    type: 'General',
    title: questionTitle,
    guidance: {
      contents: [
        {
          title: 'Remember to Include people who are<br><br>',
        },
        {
          title: 'Temporarily away',
        },
        {
          list: [
            'people who work away from home within the UK if this is their permanent or family home',
            'members of the armed forces if this is their permanent or family home',
            'people who are temporarily outside the UK for <strong>less than 12 months</strong>',
            'people staying, or expecting to stay, in an establishment such as a hospital, care home or hostel for <strong>less than 6 months</strong>',
            'other people who usually live here but are temporarily away from home',
          ],
        },
        {
          title: 'Temporarily staying',
        },
        {
          list: [
            'people staying temporarily who usually live in the UK but do not have another UK address for example, relatives, friends',
            'people who usually live outside the UK who are staying in the UK for <strong>3 months or more</strong>',
          ],
        },
      ],
    },
    answers: [
      {
        id: 'anyone-else-temp-away-answer',
        mandatory: true,
        type: 'Radio',
        options: [
          {
            label: 'Yes, I need to add someone',
            value: 'Yes, I need to add someone',
          },
          {
            label: {
              text_plural: {
                forms: {
                  one: 'No, there is {cardinal} person living here',
                  other: 'No, there are {cardinal} people living here',
                },
                count: {
                  source: 'list',
                  identifier: 'household',
                },
              },
              placeholders: [
                placeholders.cardinal,
              ],
            },
            value: 'No, I do not need to add anyone',
          },
        ],
        guidance: {
          show_guidance: 'Why we ask this question',
          hide_guidance: 'Why we ask this question',
          contents: [
            {
              description: 'We ask this question to help ensure that everyone is correctly counted in the census. This includes people who are staying temporarily or are away.',
            },
            {
              description: 'The information is vital for planning services, whether it is for hospital beds, school places, GP and dental services or where to build houses and roads.',
            },
          ],
        },
      },
    ],
  },
  add_block: {
    id: 'anyone-else-temp-away-add-person',
    type: 'ListAddQuestion',
    cancel_text: 'Don’t need to add anyone?',
    question: {
      id: 'anyone-else-temp-away-add-question',
      type: 'General',
      title: addPersonQuestionTitle,
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
      title: removePersonQuestionTitle,
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
    item_title: summaryTitlePersonName,
  },
}
