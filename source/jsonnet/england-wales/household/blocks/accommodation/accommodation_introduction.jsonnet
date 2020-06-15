local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Interstitial',
  id: 'accommodation-introduction',
  content: {
    title: 'Household and accommodation',
    contents: [
      {
        description: {
          text: 'In this section we are going to ask you about this household‘s accommodation at {household_address}.',
          placeholders: [
            placeholders.address,
          ],
        },
      },
      {
        title: 'You will need to know information such as',
        list: [
          'type of property, and if it‘s owned or rented',
          'type of landlord if rented, for example, housing association, council or private',
          'type of central heating',
        ],
      },
    ],
  },
}
