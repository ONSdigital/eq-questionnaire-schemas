local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local listName = 'household';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'One year ago, what was <strong>{person_name_possessive}</strong> usual address?',
    placeholders: [
      placeholders.personNamePossessive,
    ],
  }
  else 'One year ago, what was your usual address?'
);

local additionalAnswerOption(isFirstPerson) = (
  if isFirstPerson then []
  else [{
    label: {
      text: 'Same as {first_person_possessive} address one year ago',
      placeholders: [
        placeholders.firstPersonNamePossessiveForList(listName),
      ],
    },
    value: 'Same as {first_person_possessive} address one year ago',
  }]
);

local questionDescription(isProxy) = (
  if isProxy then [
    'If they had no usual address one year ago, select the address where they were staying.',
  ] else [
    'If you had no usual address one year ago, select the address where you were staying.',
  ]
);

local question(isProxy, isFirstPerson) = {
  id: 'location-one-year-ago-question',
  title: questionTitle(isProxy),
  type: 'General',
  description: questionDescription(isProxy),
  answers: [
    {
      id: 'location-one-year-ago-answer',
      mandatory: false,
      options: additionalAnswerOption(isFirstPerson) + [
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
      question: question(isProxy=false, isFirstPerson=true),
      when: { and: [rules.isNotProxy, rules.isFirstPersonInList(listName)] },
    },
    {
      question: question(isProxy=false, isFirstPerson=false),
      when: { and: [rules.isNotProxy, rules.isNotFirstPersonInList(listName)] },
    },
    {
      question: question(isProxy=true, isFirstPerson=true),
      when: { and: [rules.isProxy, rules.isFirstPersonInList(listName)] },
    },
    {
      question: question(isProxy=true, isFirstPerson=false),
      when: { and: [rules.isProxy, rules.isNotFirstPersonInList(listName)] },
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
