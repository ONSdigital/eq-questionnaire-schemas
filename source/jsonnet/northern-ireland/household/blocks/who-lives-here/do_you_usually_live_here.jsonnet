local placeholders = import '../../../lib/placeholders.libsonnet';

local questionTitle = {
  text: 'Do you usually live at {household_address}?',
  placeholders: [
    placeholders.address,
  ],
};

{
  id: 'do-you-usually-live-here',
  page_title: 'Where you usually live',
  type: 'PrimaryPersonListCollector',
  for_list: 'household',
  add_or_edit_block: {
    id: 'what-is-your-name',
    type: 'PrimaryPersonListAddOrEditQuestion',
    page_title: 'Name of Person {list_item_position}',
    question: {
      id: 'what-is-your-name-question',
      type: 'General',
      title: 'What is your name?',
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
    },
  },
  question: {
    id: 'do-you-usually-live-here-question',
    type: 'General',
    title: questionTitle,
    definitions: [
      {
        title: 'What we mean by “usually live”',
        contents: [
          {
            description: 'This is often your permanent or family home.',
          },
          {
            description: {
              text: 'If you have more than one address, include yourself at the home address where you spend most of your time. If you split your time equally then use the home address where you are staying overnight on {census_date}.',
              placeholders: [
                placeholders.censusDate,
              ],
            },
          },
          {
            description: '<strong>Students</strong>, include yourself at both your term-time and out of term-time addresses.',
          },
          {
            description: '<strong>Armed forces members</strong>, include yourself at your home address if you have one.',
          },
        ],
      },
    ],
    answers: [
      {
        id: 'you-live-here-answer',
        mandatory: true,
        type: 'Radio',
        options: [
          {
            label: 'Yes, I usually live here',
            value: 'Yes, I usually live here',
            action: {
              type: 'RedirectToListAddBlock',
            },
          },
          {
            label: 'No, I don’t usually live here',
            value: 'No, I don’t usually live here',
          },
        ],
      },
    ],
  },
}
