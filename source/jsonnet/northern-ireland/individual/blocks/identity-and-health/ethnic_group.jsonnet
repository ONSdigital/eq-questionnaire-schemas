local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What is your ethnic group?';
local proxyTitle = {
  text: 'What is <em>{person_name_possessive}</em> ethnic group?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};


local question(title, otherEthnicGroupDescription) = {
  id: 'ethnic-group-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-answer',
      mandatory: false,
      options: [
        {
          label: 'White',
          value: 'White',
        },
        {
          label: 'Chinese',
          value: 'Chinese',
        },
        {
          label: 'Irish Traveller',
          value: 'Irish Traveller',
        },
        {
          label: 'Roma',
          value: 'Roma',
        },
        {
          label: 'Indian',
          value: 'Indian',
        },
        {
          label: 'Filipino',
          value: 'Filipino',
        },
        {
          label: 'Black African',
          value: 'Black African',
        },
        {
          label: 'Black other',
          value: 'Black other',
        },
        {
          label: 'Mixed ethnic group',
          value: 'Mixed ethnic group',
          detail_answer: {
            id: 'ethnic-group-mixed',
            type: 'TextField',
            mandatory: false,
            label: 'Please specify mixed ethnic group',
          },
        },
        {
          label: 'Any other ethnic group',
          value: 'Any other ethnic group',
          description: otherEthnicGroupDescription,
        },
      ],
      type: 'Radio',
    },
  ],
};

{
  type: 'Question',
  id: 'ethnic-group',
  page_title: 'Ethnic group',
  question_variants: [
    {
      question: question(nonProxyTitle, 'You can enter your ethnic group on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, 'You can enter their ethnic group on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'ethnic-group-other',
        when: [
          {
            id: 'ethnic-group-answer',
            condition: 'equals',
            value: 'Any other ethnic group',
          },
        ],
      },
    },
    {
      goto: {
        block: 'religion',
      },
    },
  ],
}
