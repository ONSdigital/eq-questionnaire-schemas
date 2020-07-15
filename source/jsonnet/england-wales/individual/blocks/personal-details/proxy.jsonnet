{
  type: 'Question',
  id: 'confirm-who-is-answering',
  question: {
    id: 'confirm-who-is-answering-question',
    title: 'Are you answering these questions for yourself or for someone else?',
    type: 'General',
    answers: [
      {
        id: 'confirm-who-is-answering-answer',
        mandatory: false,
        default: 'For someone else',
        options: [
          {
            label: 'For myself',
            value: 'For myself',
          },
          {
            label: 'For someone else',
            value: 'For someone else',
          },
        ],
        type: 'Radio',
      },
    ],
  },
}
