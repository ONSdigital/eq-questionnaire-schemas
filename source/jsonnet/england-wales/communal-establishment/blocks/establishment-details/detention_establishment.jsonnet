local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'detention-establishment',
  question: {
    id: 'detention-establishment-question',
    title: {
      text: 'What type of detention establishment <em>{household_address}</em>?',
      placeholders: [
        placeholders.address,
      ],
    },
    type: 'General',
    answers: [{
      id: 'detention-establishment-answer',
      mandatory: false,
      options: [
        {
          label: 'Prison service establishment',
          value: 'Prison service establishment',
          destription: 'Including young offender institutions',
        },
        {
          label: 'Approved premises',
          value: 'Approved premises',
          description: 'Probation or bail hostel',
        },
        {
          label: 'Detention centre',
          value: 'Detention centre',
        },
        {
          label: 'Other detention establishment',
          value: 'Other detention establishment',
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
      goto: {
        block: 'live-in-establishment',
      },
    },
  ],
}
