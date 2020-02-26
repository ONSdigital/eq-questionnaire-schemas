local placeholders = import '../../../lib/placeholders.libsonnet';

local question = {
  id: 'number-of-visitors-in-establishment-question',
  title: {
    text: 'How many visitors are staying overnight in this establishment on {census_date}?',
    placeholders: [
      placeholders.censusDate,
    ],
  },
  type: 'General',
  guidance: {
    contents: [{
      description: '<em>Include</em> everyone from the groups you selected for the previous question',
    }],
  },
  answers: [
    {
      id: 'number-of-visitors-in-establishment-answer',
      label: 'Number of visitors',
      mandatory: false,
      type: 'Number',
      minimum: {
        value: 0,
      },
    },
  ],
};

{
  type: 'Question',
  id: 'number-of-visitors-in-establishment',
  question: question,
}
