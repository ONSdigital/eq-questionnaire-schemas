local placeholders = import '../../../lib/placeholders.libsonnet';

local guidance(census_date) = {
  contents: [
    {
      description: {
        text: '<em>Include</em> shift workers, for example, care workers, hotel porters, who are staying overnight on {census_date} as visitors',
        placeholders: [
          placeholders.censusDate(census_date),
        ],
      },
    },
  ],
};

local question(census_date) = {
  id: 'visitors-in-establishment-question',
  title: {
    text: 'Are any of the following visitors staying overnight in this establishment on {census_date}?',
    placeholders: [
      placeholders.censusDate(census_date),
    ],
  },
  type: 'MutuallyExclusive',
  guidance: guidance(census_date),
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


function(census_date) {
  type: 'Question',
  id: 'visitors-in-establishment',
  question: question(census_date),
  routing_rules: [
    {
      goto: {
        group: 'submit-group',
        when: [
          {
            id: 'visitors-in-establishment-exclusive',
            condition: 'set',
          },
        ],
      },
    },
    {
      goto: {
        block: 'number-of-visitors-in-establishment',
      },
    },
  ],
}
