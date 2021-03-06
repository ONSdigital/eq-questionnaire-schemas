local placeholders = import '../../../lib/placeholders.libsonnet';

local guidance = {
  contents: [
    {
      description: {
        text: '<em>Include</em> shift workers, for example, care workers, hotel porters, who are staying overnight on {census_date} as visitors',
        placeholders: [
          placeholders.censusDate,
        ],
      },
    },
  ],
};

local question = {
  id: 'visitors-in-establishment-question',
  title: {
    text: 'Are any of the following visitors staying overnight in this establishment on {census_date}?',
    placeholders: [
      placeholders.censusDate,
    ],
  },
  type: 'MutuallyExclusive',
  guidance: guidance,
  mandatory: false,
  answers: [
    {
      id: 'visitors-in-establishment-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'Anyone with another usual address in the UK who has spent, or expects to spend, less than 6 months in this establishment',
          value: 'Anyone with another usual address in the UK who has spent, or expects to spend, less than 6 months in this establishment',
        },
        {
          label: 'Anyone from outside the UK who intends to stay in the UK for less than 3 months',
          value: 'Anyone from outside the UK who intends to stay in the UK for less than 3 months',
        },
      ],
    },
    {
      id: 'visitors-in-establishment-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'None of these apply',
          value: 'None of these apply',
        },
      ],
    },
  ],
};


{
  type: 'Question',
  id: 'visitors-in-establishment',
  page_title: 'Visitors staying in this establishment',
  question: question,
  routing_rules: [
    {
      goto: {
        block: 'number-of-visitors-in-establishment',
      },
    },
  ],
}
