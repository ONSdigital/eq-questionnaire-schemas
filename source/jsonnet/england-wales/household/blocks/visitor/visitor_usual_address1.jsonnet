local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  id: 'visitor-usual-question',
  title: title,
  type: 'General',
  description: [
    description,
  ],
  answers: [
    {
      id: 'visitor-usual-answer',
      mandatory: false,
      options: [
        {
          label: {
            text: '{household_address}',
            placeholders: [
              placeholders.address,
            ],
          },
          value: 'household-address',
        },
        {
          label: 'Student term-time or boarding school address in the UK',
          value: 'Student term-time or boarding school address in the UK',
        },
        {
          label: 'Another address in the UK',
          value: 'Another address in the UK',
        },
        {
          label: 'An address outside the UK',
          value: 'Other',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'visitor-usual-answer-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter the current name of the country',
          },
        },
      ],
      type: 'Radio',
    },
  ],
};

local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> usual address?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local proxyDescription = 'If they had no usual address one year ago, state the address where they were staying';

{
  type: 'Question',
  id: 'visitor-usual-address',
  question: {
    id: 'visitor-usual-question',
    title: title,
    type: 'General',
    description: [
      description,
    ],
    answers: [
      {
        id: 'visitor-usual-answer',
        mandatory: false,
        options: [
          {
            label: 'An address in the UK',
            value: 'An address in the UK',
          },
          {
            label: 'An address outside the UK',
            value: 'Other',
            description: 'Select to enter answer',
            detail_answer: {
              id: 'visitor-usual-answer-other',
              type: 'TextField',
              mandatory: false,
              label: 'Enter the current name of the country',
            },
          },
        ],
        type: 'Radio',
      },
    ],
  },
}
