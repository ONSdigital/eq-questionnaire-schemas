local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Interstitial',
  id: 'accommodation-introduction',
  content: {
    title: 'Household and accommodation',
    contents: [
      {
        description: {
          text: 'In this section we are going to ask you about the accommodation at {household_address}.',
          placeholders: [
            placeholders.address,
          ],
        },
      },
      {
        title: 'You will need to know',
        list: [
          'Type of property',
          'Type of landlord if rented, for example, housing association, council or private',
          'Type of central heating',
        ],
      },
    ],
  },
}
