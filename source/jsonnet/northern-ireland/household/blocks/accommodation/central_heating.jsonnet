local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'central-heating',
  page_title: 'Central heating',
  question: {
    id: 'central-heating-question',
    type: 'MutuallyExclusive',
    mandatory: false,
    title: {
      text: 'What type of central heating does <em>{household_address}</em> have?',
      placeholders: [placeholders.address],
    },
    guidance: {
      contents: [
        {
          description: 'Include central heating systems that generate heat for multiple rooms whether or not you use them',
        },
      ],
    },
    answers: [
      {
        id: 'central-heating-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'Oil',
            value: 'Oil',
          },
          {
            label: 'Mains gas',
            value: 'Mains gas',
          },
          {
            label: 'Tank or bottled gas',
            value: 'Tank or bottled gas',
          },
          {
            label: 'Electric',
            value: 'Electric',
            description: 'For example storage heaters',
          },
          {
            label: 'Wood',
            value: 'Wood',
            description: 'For example logs or waste wood',
          },
          {
            label: 'Solid fuel',
            value: 'Solid fuel',
            description: 'For example coal',
          },
          {
            label: 'Renewable heating system',
            value: 'Renewable heating system',
          },
          {
            label: 'Other central heating',
            value: 'Other central heating',
          },
        ],
      },
      {
        id: 'central-heating-answer-exclusive',
        type: 'Checkbox',
        mandatory: false,
        options: [
          {
            label: 'No central heating',
            value: 'No central heating',
          },
        ],
      },
    ],
  },
}
