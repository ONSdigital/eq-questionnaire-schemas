{
  type: 'Question',
  id: 'people-in-establishment',
  question: {
    id: 'people-in-establishment-question',
    title: 'How many people are currently living in this establishment?',
    type: 'General',
    guidance: {
      contents: [{
        description: '<em>Include</em> everyone from the groups you selected for the previous question<br>\n                <br>\n                <em>Do not include</em> visitors who have another UK address, or usually live outside the UK and intend to stay in the UK for 3 months or less',
      }],
    },
    answers: [{
      id: 'people-in-establishment-answer',
      label: 'Number of residents',
      mandatory: false,
      type: 'Number',
      min_value: {
        value: 0,
      },
    }],
  },
}
