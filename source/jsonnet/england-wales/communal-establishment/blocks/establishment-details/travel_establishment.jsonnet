local placeholders = import '../../../lib/placeholders.libsonnet';

{
  type: 'Question',
  id: 'travel-establishment',
  question: {
    id: 'travel-establishment-question',
    title: {
      text: 'What type of travel or temporary accommodation establishment is <em>{household_address}</em>?',
      placeholders: [
        placeholders.address,
      ],
    },
    type: 'General',
    answers: [{
      id: 'travel-establishment-answer',
      mandatory: false,
      options: [
        {
          label: 'Hotel, guest house, B&B, youth hostel',
          value: 'Hotel, guest house, B&B, youth hostel',
          description: 'Including inns and pubs',
        },
        {
          label: 'Holiday accommodation',
          value: 'Holiday accommodation',
          description: 'For example, holiday park',
        },
        {
          label: 'Hostel or temporary shelter for homeless people',
          value: 'Hostel or temporary shelter for homeless people',
        },
        {
          label: 'Other travel or temporary accommodation',
          value: 'Other travel or temporary accommodation',
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
