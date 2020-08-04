{
  type: 'Question',
  id: 'type-of-flat',
  question: {
    id: 'type-of-flat-question',
    title: 'Where is your flat, maisonette or apartment?',
    type: 'General',
    answers: [{
      id: 'type-of-flat-answer',
      mandatory: false,
      options: [
        {
          label: 'In a purpose-built block of flats or tenement',
          value: 'In a purpose-built block of flats or tenement',
        },
        {
          label: 'Part of a converted or shared house',
          value: 'Part of a converted or shared house',
          description: 'Including bedsits',
        },
        {
          label: 'Part of another converted building',
          value: 'Part of another converted building',
          description: 'For example, former school, church or warehouse',
        },
        {
          label: 'In a commercial building',
          value: 'In a commercial building',
          description: 'For example, in an office building, hotel, or over a shop',
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [{
    goto: {
      block: 'rooms-shared-with-another-household',
    },
  }],
}
