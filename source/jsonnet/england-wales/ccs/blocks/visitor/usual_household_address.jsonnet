local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local listName = 'visitors';

local additionalAnswerOption = [
  {
    label: {
      text: 'Same address as {first_person}',
      placeholders: [
        placeholders.firstPersonNameForList(listName),
      ],
    },
    value: 'Same address as {visitor_name}',
  },
];

local question(additionalAnwerOptions=[]) = {
  id: 'usual-address-household-question',
  title: {
    text: 'Did <em>{person_name}</em> usually live in the UK?',
    placeholders: [
      placeholders.personName,
    ],
  },
  type: 'General',
  answers: [
    {
      id: 'usual-address-household-answer',
      mandatory: false,
      options: additionalAnwerOptions + [
        {
          label: 'An address in the UK',
          value: 'An address in the UK',
        },
        {
          label: 'An address outside the UK',
          value: 'An address outside the UK',
          description: 'Select to enter answer',
          detail_answer: {
            id: 'usual-address-household-answer-other',
            type: 'TextField',
            mandatory: false,
            label: 'Enter current name of country',
          },
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'usual-household-address',
  question_variants: [
    {
      question: question(),
      when: [rules.isFirstPersonInList(listName)],
    },
    {
      question: question(additionalAnswerOption),
      when: [rules.isNotFirstPersonInList(listName)],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'usual-address-details',
        when: [
          {
            id: 'usual-address-household-answer',
            condition: 'equals',
            value: 'An address in the UK',
          },
        ],
      },
    },
    {
      goto: {
        section: 'End',
      },
    },
  ],
}
