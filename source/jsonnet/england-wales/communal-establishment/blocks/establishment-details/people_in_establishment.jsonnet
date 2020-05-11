local question = {
  id: 'people-in-establishment-question',
  title: 'How many people are currently living in this establishment?',
  type: 'General',
  guidance: {
    contents: [
      {
        description: '<em>Include</em> everyone from the groups you selected for the previous question',
      },
      {
        description: '<em>Do not include</em> visitors who have another UK address, or usually live outside the UK and intend to stay in the UK for 3 months or less',
      },
    ],
  },
  answers: [{
    id: 'people-in-establishment-answer',
    label: 'Number of residents',
    mandatory: false,
    type: 'Number',
    minimum: {
      value: 0,
    },
  }],
};

local questionWithExclusive = {
  id: 'people-in-establishment-question',
  title: 'How many people are currently living in this establishment?',
  type: 'MutuallyExclusive',
  mandatory: false,
  guidance: {
    contents: [
      {
        description: '<em>Do not include</em> visitors who have another UK address, or usually live outside the UK and intend to stay in the UK for 3 months or less',
      },
    ],
  },
  answers: [
    {
      id: 'people-in-establishment-answer',
      label: 'Number of residents',
      mandatory: false,
      type: 'Number',
      minimum: {
        value: 0,
      },
    },
    {
      id: 'people-in-establishment-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'No one is living in this establishment',
          value: 'No one is living in this establishment',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'people-in-establishment',
  question_variants: [
    {
      question: question,
      when: [
        {
          id: 'live-in-establishment-answer',
          condition: 'set',
        },
      ],
    },
    {
      question: questionWithExclusive,
      when: [
        {
          id: 'live-in-establishment-exclusive',
          condition: 'set',
        },
      ],
    },
    {
      question: questionWithExclusive,
      when: [
        {
          id: 'live-in-establishment-answer',
          condition: 'not set',
        },
      ],
    },
  ],
}
