local placeholders = import '../../../lib/placeholders.libsonnet';

local contentDescription = {
  text: 'In this section, we are counting the people at {household_address} on Sunday {census_date}.',
  placeholders: [
    placeholders.censusDate,
    placeholders.address,
  ],
};

{
  type: 'Interstitial',
  id: 'who-lives-here-interstitial',
  content: {
    title: {
      text: 'People who live at {household_address}',
      placeholders: [
        placeholders.address,
      ],
    },
    contents: [
      {
        description: contentDescription,
      },
      {
        title: 'You will need to know',
        list: [
          'names of people living at this address, including anyone currently away.',
          {
            text: 'names of visitors staying overnight in this household on {census_date}.',
            placeholders: [
              placeholders.censusDate,
            ],
          },
        ],
      },
    ],
  },
}
