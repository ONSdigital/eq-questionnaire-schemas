{
  type: 'Question',
  id: 'nature-of-establishment',
  question: {
    id: 'nature-of-establishment-question',
    title: 'What is the nature of this establishment?',
    type: 'General',
    answers: [{
      id: 'nature-of-establishment-answer',
      mandatory: true,
      options: [
        {
          label: 'Medical or care',
          value: 'Medical or care',
          description: 'For example, care homes, children’s homes or hospitals',
        },
        {
          label: 'Education',
          value: 'Education',
          description: 'Including halls of residence',
        },
        {
          label: 'Armed forces',
          value: 'Armed forces',
          description: 'Defence establishments, including ships',
        },
        {
          label: 'Detention',
          value: 'Detention',
          description: 'For example, prisons or approved premises',
        },
        {
          label: 'Travel or temporary accomodation',
          value: 'Travel or temporary accomodation',
          description: 'Includes shelters for homeless people',
        },
        {
          label: 'Religious establishment',
          value: 'Religious establishment',
        },
        {
          label: 'Staff or worker accomodation only',
          value: 'Staff or worker accomodation only',
        },
        {
          label: 'Other establishment',
          value: 'Other establishment',
        },
      ],
      type: 'Radio',
    }],
  },
  routing_rules: [
    {
      goto: {
        block: 'medical-establishment',
        when: [
          {
            id: 'nature-of-establishment-answer',
            condition: 'equals',
            value: 'Medical or care',
          },
        ],
      },
    },
    {
      goto: {
        block: 'education-establishment',
        when: [
          {
            id: 'nature-of-establishment-answer',
            condition: 'equals',
            value: 'Education',
          },
        ],
      },
    },
    {
      goto: {
        block: 'live-in-establishment',
        when: [
          {
            id: 'nature-of-establishment-answer',
            condition: 'equals any',
            values: ['Armed forces', 'Staff or worker accomodation only'],
          },
        ],
      },
    },
    {
      goto: {
        block: 'detention-establishment',
        when: [
          {
            id: 'nature-of-establishment-answer',
            condition: 'equals',
            value: 'Detention',
          },
        ],
      },
    },
    {
      goto: {
        block: 'travel-establishment',
        when: [
          {
            id: 'nature-of-establishment-answer',
            condition: 'equals',
            value: 'Travel or temporary accomodation',
          },
        ],
      },
    },
    {
      goto: {
        block: 'live-in-establishment',
      },
    },
  ],
}
