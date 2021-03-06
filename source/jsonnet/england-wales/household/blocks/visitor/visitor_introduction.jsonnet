local placeholders = import '../../../lib/placeholders.libsonnet';


{
  type: 'Interstitial',
  id: 'visitor-introduction',
  page_title: 'Introduction to visitor questions',
  content: {
    title: {
      text: '{person_name}',
      placeholders: [
        placeholders.personName(),
      ],
    },
    contents: [
      {
        description: {
          text: 'In this section, we are going to ask you about your visitor, <strong>{person_name}</strong>.',
          placeholders: [
            placeholders.personName(),
          ],
        },
      },
      {
        title: 'You will need to know',
        list: [
          'date of birth',
          'sex',
          'usual address',
        ],
      },
    ],
  },
}
