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
    value: 'Same address as {first_person}',
  },
];

local question(additionalAnswerOptions=[]) = {
  id: 'usual-address-household-question',
  title: {
    text: 'What is <em>{person_name_possessive}</em> usual address?',
    placeholders: [
      placeholders.personNamePossessive,
    ],
  },
  type: 'General',
  answers: [
    {
      guidance: {
        show_guidance: 'Why we ask for visitor details',
        hide_guidance: 'Why we ask for visitor details',
        contents: [
          {
            description: 'Your answer helps to ensure that everyone is counted in the census. Add visitor details, even if you think they have been included on a census questionnaire at another address.',
          },
        ],
      },
      id: 'usual-address-household-answer',
      mandatory: false,
      options: additionalAnswerOptions + [
        {
          label: 'An address in the UK',
          value: 'An address in the UK',
        },
        {
          label: 'An address outside the UK',
          value: 'An address outside the UK',
          description: 'You can enter their country on the next question',
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
        block: 'usual-household-address-other',
        when: [
          {
            id: 'usual-address-household-answer',
            condition: 'equals',
            value: 'An address outside the UK',
          },
        ],
      },
    },
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
