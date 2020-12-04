local placeholders = import '../../../lib/placeholders.libsonnet';

local contentDescription = {
  text: 'In this section, we are counting the people in this household at {household_address} on <strong>Sunday {census_date}</strong>.',
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
      text: 'People who live in this household at {household_address}',
      placeholders: [
        placeholders.address,
      ],
    },
    contents: [
      {
        description: contentDescription,
      },
      {
        definition: {
          title: 'What we mean by “this household”',
          contents: [
            {
              description: 'This is one person living alone or a group of people, not necessarily related, living at the same address, who share cooking facilities <em>and</em> share a living room <em>or</em> sitting room <em>or</em> dining area.',
            },
            {
              description: 'Any other household at this address will need to request a new household access code to start their own census.',
            },
          ],
        },
      }
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
