local placeholders = import '../../../lib/placeholders.libsonnet';
{
  type: 'Interstitial',
  id: 'accommodation-introduction',
  content: {
    title: 'Household and accommodation',
    contents: [
      {
        description: {
        text: 'In this section, I’m going to ask you about the household and accommodation you were living in on {census_date}.',
        placeholders: [
            placeholders.censusDate,
          ],
       },
      },
    ],
  },
}
