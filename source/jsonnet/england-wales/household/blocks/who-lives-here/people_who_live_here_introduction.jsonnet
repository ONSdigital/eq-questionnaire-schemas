local placeholders = import '../../../lib/placeholders.libsonnet';

local contentDescription = {
  text: 'In this section, we are counting the people at {household_address} on <strong>Sunday {census_date}</strong>.',
  placeholders: [
    placeholders.censusDate,
    placeholders.address,
  ],
};

{
  type: 'Interstitial',
  page_title: 'Introduction to people who live here',
  id: 'people-who-live-here-introduction',
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
          'names of people living at this address, including anyone currently away',
          {
            text: 'names of visitors staying overnight in this household on {census_date}',
            placeholders: [
              placeholders.censusDate,
            ],
          },
        ],
      },
      {
        description: 'The Householder is responsible for ensuring that this questionnaire is completed and submitted.',
      },
    ],
  },
}
