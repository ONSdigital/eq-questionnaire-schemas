local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Interstitial',
  id: 'who-lives-here-interstitial',
  content: {
    title: 'Your household',
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
        description: 'A <strong>household</strong> is one person living alone, or a group of people (not necessarily related), who share cooking facilities <em>and</em> share a\n        living room, <strong>or</strong> sitting room, <strong>or</strong> dining area.',
      },
      {
        description: 'Some of the questions that I will ask have showcards to help you to answer.',
      },
      {
        description: 'I will show you these on paper or on the phone screen.',
      },
    ],
  },
}
