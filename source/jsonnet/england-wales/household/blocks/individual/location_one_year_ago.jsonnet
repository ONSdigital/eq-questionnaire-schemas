local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local listName = 'household';

local questionTitle(isProxy) = (
  if isProxy then {
    text: 'One year ago, what was <em>{person_name_possessive}</em> usual address?',
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
    'If the <strong>coronavirus</strong> pandemic affected their usual address one year ago, select where you were living <strong>before your circumstances changed</strong>.',
  ] else [
    'If you had no usual address one year ago, select the address where you were staying.',
    'If the <strong>coronavirus</strong> pandemic affected your usual address one year ago, select where you were living <strong>before your circumstances changed</strong>.',
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
          label: 'An address outside the UK',
          value: 'An address outside the UK',
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
      when: [rules.isNotProxy, rules.isFirstPersonInList(listName)],
    },
    {
      question: question(isProxy=false, isFirstPerson=false),
      when: [rules.isNotProxy, rules.isNotFirstPersonInList(listName)],
    },
    {
      question: question(isProxy=true, isFirstPerson=true),
      when: [rules.isProxy, rules.isFirstPersonInList(listName)],
    },
    {
      question: question(isProxy=true, isFirstPerson=false),
      when: [rules.isProxy, rules.isNotFirstPersonInList(listName)],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'address-one-year-ago',
        when: [
          {
            id: 'location-one-year-ago-answer',
            condition: 'equals',
            value: 'Student term-time or boarding school address in the UK',
          },
        ],
      },
    },
    {
      goto: {
        block: 'address-one-year-ago',
        when: [
          {
            id: 'location-one-year-ago-answer',
            condition: 'equals',
            value: 'Another address in the UK',
          },
        ],
      },
    },
    {
      goto: {
        block: 'address-one-year-ago-outside-uk',
        when: [
          {
            id: 'location-one-year-ago-answer',
            condition: 'equals',
            value: 'An address outside the UK',
          },
        ],
      },
    },
    {
      goto: {
        block: 'national-identity',
      },
    },
  ],
}
