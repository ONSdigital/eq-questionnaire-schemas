local placeholders = import '../../../lib/placeholders.libsonnet';


{
  type: 'Interstitial',
  id: 'individual-introduction',
  content: {
    title: {
      text: '{person_name}',
      placeholders: [
        placeholders.personName,
      ],
    },
    contents: [
      {
        description: {
          text: 'In this section, we are going to ask you questions about <strong>{person_name}</strong>.',
          placeholders: [
            placeholders.personName,
          ],
        },
      },
      {
        title: 'You will need to know personal details such as',
        list: [
          'date of birth',
          'country of birth',
          'second or holiday homes',
          'main language',
          'general health',
          'unpaid care provided',
          'qualifications',
          'employment details',
        ],
      },
    ],
  },
}
