local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'other-living-accommodation',
  question: {
    id: 'other-living-accommodation-question',
    description: [
      'For example, separate bedsits, annexes, sheds',
    ],
    title: {
      text: 'Is there any other living accommodation at {household_address}?',
      placeholders: [
        placeholders.address,
      ],
    },
    type: 'General',
    instruction: ['If yes, ensure this accommodation is recorded on the Totalmobile App and interview household'],
    answers: [{
      id: 'other-living-accommodation-answer',
      mandatory: false,
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
      type: 'Radio',
    }],
  },
}
