local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'One year ago, what was <strong>{person_name_possessive}</strong> usual address?',
    placeholders: [
      placeholders.personNamePossessive,
    ],
  }
  else 'One year ago, what was your usual address?'
);


local question(isProxy) = {
  id: 'location-one-year-ago-question',
  title: questionTitle(isProxy),
  type: 'General',
  answers: [
    {
      id: 'location-one-year-ago-answer',
      mandatory: false,
      options: [
        {
          label: {
            text: '{household_address}',
            placeholders: [
              placeholders.address,
            ],
          },
          value: '{household_address}',
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
          label: 'Another address outside the UK',
          value: 'Another address outside the UK',
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'location-one-year-ago',
  page_title: 'Location one year ago',
  question_variants: [
    {
      question: question(isProxy=false),
      when: rules.isNotProxy,
    },
    {
      question: question(isProxy=true),
      when: rules.isProxy,
    },
  ],
  routing_rules: [
    {
      block: 'address-one-year-ago',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'location-one-year-ago-answer',
          },
          'Student term-time or boarding school address in the UK',
        ],
      },
    },
    {
      block: 'address-one-year-ago',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'location-one-year-ago-answer',
          },
          'Another address in the UK',
        ],
      },
    },
    {
      block: 'address-one-year-ago-outside-uk',
      when: {
        '==': [
          {
            source: 'answers',
            identifier: 'location-one-year-ago-answer',
          },
          'Another address outside the UK',
        ],
      },
    },
    {
      block: 'national-identity',
    },
  ],
}
