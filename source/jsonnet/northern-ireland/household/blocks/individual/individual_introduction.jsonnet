local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Interstitial',
  id: 'individual-introduction',
  page_title: 'Introduction to individual questions',
  content: {
    title: {
      text: '{person_name}',
      placeholders: [
        placeholders.personName(includeMiddleNames='if_is_same_name'),
      ],
    },
    contents: [
      {
        description: {
          text: 'In this section, we’re going to ask you questions about <strong>{person_name}</strong>.',
          placeholders: [
            placeholders.personName(includeMiddleNames='if_is_same_name'),
          ],
        },
      },
      {
        title: 'You will need to know personal details such as',
        list: [
          'date of birth or age',
          'student status',
          'employment details',
        ],
      },
      {
        description: {
          text: 'Circumstances for <strong>{person_name}</strong> may have changed during the coronavirus pandemic. Answer all questions based on the situation as it is now.',
          placeholders: [
            placeholders.personName(includeMiddleNames='if_is_same_name'),
          ],
        },
      },
    ],
  },
}
