local placeholders = import '../../../lib/placeholders.libsonnet';


{
  type: 'Interstitial',
  id: 'visitor-introduction',
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
          text: 'In this section, I’m going to ask you about your visitor, <em>{person_name}</em>',
          placeholders: [
            placeholders.personName(),
          ],
        },
      },
    ],
  },
}
