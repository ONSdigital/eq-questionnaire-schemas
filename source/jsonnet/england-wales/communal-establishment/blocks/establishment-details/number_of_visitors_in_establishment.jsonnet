local placeholders = import '../../../lib/placeholders.libsonnet';

local question(census_date) = {
  id: 'number-of-visitors-in-establishment-question',
  title: {
    text: 'How many visitors are staying overnight in this establishment on {census_date}?',
    placeholders: [
      placeholders.censusDate(census_date),
    ],
  },
  type: 'General',
  guidance: {
    contents: [{
      description: '<em>Include</em> everyone from the groups you selected for the previous question<br>',
    }],
  },
  answers: [
    {
      id: 'number-of-visitors-in-establishment-answer',
      label: 'Number of visitors',
      mandatory: false,
      type: 'Number',
      min_value: {
        value: 0,
      },
    },
  ],
};

function(census_date) {
  type: 'Question',
  id: 'number-of-visitors-in-establishment',
  question: question(census_date),
}
