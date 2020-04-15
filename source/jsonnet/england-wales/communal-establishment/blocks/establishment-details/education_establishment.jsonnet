local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'education-establishment',
  question: {
    id: 'education-establishment-question',
    title: {
      text: 'What type of education establishment is <em>{household_address}</em>?',
      placeholders: [
        placeholders.address,
      ],
    },
    type: 'General',
    answers: [{
      id: 'education-establishment-answer',
      mandatory: false,
      options: [
        {
          label: 'School',
          value: 'School',
        },
        {
          label: 'University',
          value: 'University',
          description: 'For example, hall of residence',
        },
        {
          label: 'Other education establishment',
          value: 'Other education establishment',
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
      goto: {
        block: 'responsible-for-establishment',
      },
    },
  ],
}
