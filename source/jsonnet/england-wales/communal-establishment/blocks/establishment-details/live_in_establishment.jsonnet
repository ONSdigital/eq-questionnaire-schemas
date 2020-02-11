local placeholders = import '../../../lib/placeholders.libsonnet';

local alreadySpentAnswerLabel(census_date) = {
  text: 'Anyone who has already spent, or is expected to spend, 6 months or more in this establishment, even if they are away on {census_date}',
  placeholders: [
    placeholders.censusDate(census_date),
  ],
};

local alreadyStayingAnswerLabel(census_date) = {
  text: 'UK residents who are staying in this establishment on {census_date} and have no other usual UK address',
  placeholders: [
    placeholders.censusDate(census_date),
  ],
};

local question(census_date) = {
  id: 'live-in-establishment-question',
  title: 'Do any of the following currently live in this establishment?',
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'live-in-establishment-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: alreadySpentAnswerLabel(census_date),
          value: 'Anyone who has already spent, or is expected to spend, 6 months or more in this establishment, even if they are away on {census_date}',
        },
        {
          label: alreadyStayingAnswerLabel(census_date),
          value: 'UK residents who are staying in this establishment on {census_date} and have no other usual UK address',
        },
        {
          label: 'People who usually live outside the UK who have stayed, or intend to stay, in the UK for 3 months or more who do not have another UK address',
          value: 'People who usually live outside the UK who have stayed, or intend to stay, in the UK for 3 months or more who do not have another UK address',
        },
        {
          label: 'Students or schoolchildren who stay in this establishment during term time',
          value: 'Students or schoolchildren who stay in this establishment during term time',
        },
        {
          label: 'Yourself, your family, staff, and any others who live in this establishment',
          value: 'Yourself, your family, staff, and any others who live in this establishment',
        },
      ],
    },
    {
      id: 'live-in-establishment-exclusive',
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
  id: 'live-in-establishment',
  question: question(census_date),
  routing_rules: [
    {
      goto: {
        block: 'visitors-in-establishment',
        when: [
          {
            id: 'live-in-establishment-exclusive',
            condition: 'set',
          },
        ],
      },
    },
    {
      goto: {
        block: 'people-in-establishment',
      },
    },
  ],
}
