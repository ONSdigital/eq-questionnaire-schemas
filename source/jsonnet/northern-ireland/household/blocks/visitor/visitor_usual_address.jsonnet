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
  id: 'visitor-usual-question',
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
      id: 'visitor-usual-answer',
      mandatory: false,
      options: additionalAnswerOptions + [
        {
          label: 'An address in the UK',
          value: 'An address in the UK',
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
  id: 'visitor-usual-address',
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
        block: 'visitor-usual-address-country',
        when: [
          {
            id: 'visitor-usual-answer',
            condition: 'equals',
            value: 'An address outside the UK',
          },
        ],
      },
    },
    {
      goto: {
        block: 'visitor-usual-address-details',
        when: [
          {
            id: 'visitor-usual-answer',
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
