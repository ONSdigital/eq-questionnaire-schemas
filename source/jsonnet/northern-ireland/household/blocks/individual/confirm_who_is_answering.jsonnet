local placeholders = import '../../../lib/placeholders.libsonnet';


{
  type: 'Question',
  id: 'confirm-who-is-answering',
  page_title: 'Who is answering',
  question: {
    id: 'confirm-who-is-answering-question',
    title: {
      text: 'Are you <em>{person_name}?</em>',
      placeholders: [
        placeholders.personName('is_same_name'),
      ],
    },
    type: 'General',
    answers: [
      {
        id: 'confirm-who-is-answering-answer',
        mandatory: false,
        default: 'No, I am answering on their behalf',
        options: [
          {
            label: 'Yes, I am',
            value: 'Yes, I am',
          },
          {
            label: 'No, I am answering on their behalf',
            value: 'No, I am answering on their behalf',
          },
        ],
        type: 'Radio',
      },
    ],
  },
}
