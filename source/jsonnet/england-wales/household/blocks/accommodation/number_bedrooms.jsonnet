{
  type: 'Question',
  id: 'number-of-bedrooms',
  page_title: 'Number of bedrooms',
  question: {
    id: 'number-of-bedrooms-question',
    title: 'How many bedrooms are available for use only by this household?',
    type: 'General',
    guidance: {
      contents: [{
        description: 'Include all rooms built or converted for use as bedrooms',
      }],
    },
    answers: [{
      id: 'number-of-bedrooms-answer',
      label: 'Number of bedrooms',
      mandatory: false,
      type: 'Number',
      maximum: {
        value: 99,
      },
    }],
  },
  routing_rules: [{
    goto: {
      block: 'central-heating',
    },
  }],
}
