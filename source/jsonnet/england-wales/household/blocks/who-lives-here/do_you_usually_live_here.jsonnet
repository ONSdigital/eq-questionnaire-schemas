local placeholders = import '../../../lib/placeholders.libsonnet';

{
  id: 'do-you-usually-live-here',
  type: 'PrimaryPersonListCollector',
  for_list: 'household',
  add_or_edit_answer: {
    id: 'do-you-usually-live-here-answer',
    value: 'Yes, I usually live here',
  },
  add_or_edit_block: {
    id: 'what-is-your-name',
    type: 'PrimaryPersonListAddOrEditQuestion',
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
    title: {
      text: 'Do you usually live at {household_address}?',
      placeholders: [
        placeholders.address,
      ],
    },
    definitions: [
      {
        title: 'What we mean by “usually live”',
        contents: [
          {
            description: 'This is often your permanent or family home.',
          },
          {
            description: {
              text: 'If you have more than one address, include yourself at the home address where you generally spend most of your time. If you split your time equally then use the home address where you are staying overnight on Sunday {census_date}.',
              placeholders: [
                placeholders.censusDate,
              ],
            },
          },
          {
            description: '<strong>Students</strong>, include yourself at both your term-time and out of term-time addresses.',
          },
          {
            description: '<strong>People with a second address for work</strong>, include yourself at your home address.',
          },
          {
            description: '<strong>Armed forces members</strong>, include yourself at your home address if you have one.',
          },
        ],
      },
    ],
    answers: [
      {
        id: 'do-you-usually-live-here-answer',
        mandatory: true,
        type: 'Radio',
        options: [
          {
            label: 'Yes, I usually live here',
            value: 'Yes, I usually live here',
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
