local placeholders = import '../../../lib/placeholders.libsonnet';


{
  type: 'Interstitial',
  id: 'visitor-interstitial',
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
          text: 'In this section, I’m going to ask you about your visitor, {person_name}.',
          placeholders: [
            placeholders.personName,
          ],
        },
      },
    ],
  },
}
