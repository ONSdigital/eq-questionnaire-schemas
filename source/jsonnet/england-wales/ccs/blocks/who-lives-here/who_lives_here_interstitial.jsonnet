local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Interstitial',
  id: 'who-lives-here-interstitial',
  content: {
    title: 'Household definition',
    contents: [
      {
        description: {
          text: 'All the questions are about the people in your household on Sunday {census_date}.',
          placeholders: [
            placeholders.censusDate,
          ],
        },
      },
      {
        description: 'A <em>household</em> is one person living alone, or a group of people (not necessarily related), who share cooking facilities, and share a\n        living room <em>or</em> sitting room, <em>or</em> dining area.',
      },
      {
        description: 'Some of the questions that I will ask have showcards to help you to answer.',
      },
      {
        description: 'I will show you these on paper/on the phone screen.',
      },
    ],
  },
}
