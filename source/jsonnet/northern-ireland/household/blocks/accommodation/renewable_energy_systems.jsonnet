local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

{
  type: 'Question',
  id: 'renewable-energy-systems',
  page_title: 'Renewable energy systems',
  question: {
    id: 'renewable-energy-systems-question',
    mandatory: false,
    title: {
      text: 'What type of renewable energy systems does <em>{household_address}</em> have?',
      placeholders: [placeholders.address],
    },
    type: 'MutuallyExclusive',
    answers: [
      {
        id: 'renewable-energy-systems-answer',
        mandatory: false,
        type: 'Checkbox',
        options: [
          {
            label: 'Solar panels for electricity',
            value: 'Solar panels for electricity',
          },
          {
            label: 'Solar panels for heating water',
            value: 'Solar panels for heating water',
          },
          {
            label: 'Wind turbine',
            value: 'Wind turbine',
          },
          {
            label: 'Other',
            value: 'Other',
            detail_answer: {
              id: 'renewable-energy-systems-answer-other',
              type: 'TextField',
              mandatory: false,
              label: 'Enter renewable energy system',
            },
          },
        ],
      },
      {
        id: 'renewable-energy-systems-answer-exclusive',
        type: 'Checkbox',
        mandatory: false,
        options: [
          {
            label: 'No renewable energy systems',
            value: 'No renewable energy systems',
          },
        ],
      },
    ],
  },
  routing_rules: [
    {
      goto: {
        section: 'End',
        when: [rules.listIsEmpty('household')],
      },
    },
    {
      goto: {
        block: 'own-or-rent',
      },
    },
  ],
}
