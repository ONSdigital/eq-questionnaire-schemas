local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'separate-household',
  question: {
    id: 'separate-household-question',
    description: [
      'A <strong>household</strong> is one person living alone, or a group of people (not necessarily related), who share cooking facilities <strong>and</strong> share a living room, <strong>or</strong> sitting room, <strong>or</strong> dining area'
    ],
    instruction: 'If yes, record these people on the Fieldwork Management Tool and interview them, if at this address',
    title: {
      text: 'Was there anyone living at your address on {census_date} that you have not included because they lived in a separate household?',
      placeholders: [
        placeholders.censusDate,
      ],
    },
    type: 'General',
    answers: [{
      id: 'separate-household-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No',
          value: 'No',
        },
      ],
      type: 'Radio',
    }],
  },
}
