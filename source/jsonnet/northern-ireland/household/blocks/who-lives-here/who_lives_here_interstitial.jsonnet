local placeholders = import '../../../lib/placeholders.libsonnet';

local contentDescription = {
  text: 'In this section, we’re going to ask you about the people living or staying at {household_address}.',
  placeholders: [
    placeholders.address,
  ],
};

{
  type: 'Interstitial',
  id: 'who-lives-here-interstitial',
  content: {
    title: 'People who live here',
    contents: [
      {
        description: contentDescription,
      },
      {
        title: 'You will need to know',
        list: [
          'names of people living at this address, including anyone currently away',
          {
            text: 'names of visitors staying overnight in this household on {census_date}',
            placeholders: [
              placeholders.censusDate,
            ],
          },
        ],
      },
    ],
  },
}
