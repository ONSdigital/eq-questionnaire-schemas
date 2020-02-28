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
          'Names of the people living at this address including anyone temporarily away or who has been or intends to be in the UK for 3 months or more.',
          {
            text: 'Names of visitors staying overnight at this address on {census_date}',
            placeholders: [
              placeholders.censusDate,
            ],
          },
        ],
      },
    ],
  },
}
