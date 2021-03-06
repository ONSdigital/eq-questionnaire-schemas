local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'adapted-accommodation',
  page_title: 'Adapted accommodation',
  question: {
    id: 'adapted-accommodation-question',
    mandatory: false,
    type: 'MutuallyExclusive',
    title: {
      text: 'Has <em>{household_address}</em> been designed or adapted for any of the following?',
      placeholders: [placeholders.address],
    },
    answers: [
      {
        id: 'adapted-accommodation-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'Internal wheelchair usage',
            value: 'Internal wheelchair usage',
            description: 'For example a downstairs bathroom',
          },
          {
            label: 'External wheelchair access',
            value: 'External wheelchair access',
            description: 'For example a ramp',
          },
          {
            label: 'Other physical or mobility difficulties',
            value: 'Other physical or mobility difficulties',
          },
          {
            label: 'Visual difficulties',
            value: 'Visual difficulties',
          },
          {
            label: 'Hearing difficulties',
            value: 'Hearing difficulties',
          },
          {
            label: 'Other',
            value: 'Other',
            detail_answer: {
              id: 'adapted-accommodation-answer-other',
              type: 'TextField',
              mandatory: false,
              label: 'Enter adaptation',
            },
          },
        ],
      },
      {
        id: 'adapted-accommodation-answer-exclusive',
        type: 'Checkbox',
        mandatory: false,
        options: [
          {
            label: 'None of these',
            value: 'None of these',
          },
        ],
      },
    ],
  },
}
