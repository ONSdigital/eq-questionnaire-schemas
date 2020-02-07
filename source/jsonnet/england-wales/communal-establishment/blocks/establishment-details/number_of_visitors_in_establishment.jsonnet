{
  type: 'Question',
  id: 'number-of-visitors-in-establishment',
  question: {
    id: 'number-of-visitors-in-establishment-question',
    title: 'How many visitors are staying overnight in this establishment on 21 March 2021?',
    type: 'General',
    guidance: {
      contents: [{
        description: '<em>Include</em> everyone from the groups you selected for the previous question<br>',
      }],
    },
    answers: [{
      id: 'number-of-visitors-in-establishment-answer',
      label: 'Number of visitors',
      mandatory: false,
      type: 'Number',
      min_value: {
        value: 0,
      },
    }],
  },
}
