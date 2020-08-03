local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'anyone-else-usually-living-here',
  question: {
    id: 'anyone-else-usually-living-here-question',
    title: {
      text: 'Was anyone in your current household usually living here on Sunday {census_date}?',
      placeholders: [
        placeholders.censusDate,
      ],
    },
    type: 'General',
    answers: [{
      id: 'anyone-else-usually-living-here-answer',
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
  routing_rules: [
    {
      goto: {
        block: 'usual-address-in-uk',
        when: [
          {
            id: 'anyone-else-usually-living-here-answer',
            condition: 'equals',
            value: 'No',
          },
        ],
      },
    },
    {
      goto: {
        block: 'who-to-interview-note',
      },
    },
  ],
}
