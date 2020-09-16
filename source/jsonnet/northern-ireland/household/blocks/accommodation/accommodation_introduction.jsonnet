local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Interstitial',
  id: 'accommodation-introduction',
  page_title: 'Introduction to household and accommodation',
  content: {
    title: 'Household accommodation',
    contents: [
      {
        description: {
          text: 'In this section, we’re going to ask you about the accommodation at {household_address}.',
          placeholders: [
            placeholders.address,
          ],
        },
      },
      {
        title: 'You will need to know',
        list: [
          'type of property, for example, detached, semi-detached or flat',
          'household adaptations',
          'type of central heating',
          'renewable energy systems',
        ],
      },
    ],
  },
}
