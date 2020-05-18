local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'How would you describe your national identity?';
local proxyTitle = {
  text: 'How would <em>{person_name}</em> describe their national identity?',
  placeholders: [
    placeholders.personName,
  ],
};

local question(title, otherDescription) = {
  id: 'national-identity-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'national-identity-answer',
      mandatory: false,
      type: 'Checkbox',
      options: [
        {
          label: 'British',
          value: 'British',
        },
        {
          label: 'Irish',
          value: 'Irish',
        },
        {
          label: 'Northern Irish',
          value: 'Northern Irish',
        },
        {
          label: 'English',
          value: 'English',
        },
        {
          label: 'Scottish',
          value: 'Scottish',
        },
        {
          label: 'Welsh',
          value: 'Welsh',
        },
        {
          label: 'Other',
          value: 'Other',
          description: otherDescription,
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'national-identity',
  question_variants: [
    {
      question: question(nonProxyTitle, 'You can enter your national identity on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, 'You can enter their national identity on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
  {
      goto: {
        block: 'national-identity-additional-other',
        when: [
          {
            id: 'national-identity-answer',
            condition: 'contains any',
            values: ['British', 'Irish', 'Northern Irish','English', 'Scottish', 'Welsh'],
          },
          {
            id: 'national-identity-answer',
            condition: 'contains',
            value: 'Other',
          },
        ],
      },
    },
    {
      goto: {
        block: 'national-identity-other',
        when: [
          {
            condition: 'contains',
            id: 'national-identity-answer',
            value: 'Other',
          },
        ],
      },
    },
    {
      goto: {
        block: 'ethnic-group',
      },
    },
  ],
}
