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

local questionWithExclusive = {
  id: 'number-of-visitors-in-establishment-question',
  title: {
    text: 'How many visitors are staying overnight in this establishment on {census_date}?',
    placeholders: [
      placeholders.censusDate,
    ],
  },
  type: 'MutuallyExclusive',
  mandatory: false,
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
    {
      id: 'number-of-visitors-in-establishment-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'No visitors are staying overnight',
          value: 'No visitors are staying overnight',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'number-of-visitors-in-establishment',
  page_title: 'Number of visitors staying in this establishment',
  question_variants: [
    {
      question: questionWithExclusive,
      when: [
        {
          id: 'visitors-in-establishment-exclusive',
          condition: 'set',
        },
      ],
    },
    {
      question: question,
      when: [
        {
          id: 'visitors-in-establishment-answer',
          condition: 'set',
        },
      ],
    },
    {
      question: questionWithExclusive,
      when: [
        {
          id: 'visitors-in-establishment-answer',
          condition: 'not set',
        },
      ],
    },
  ],
}
