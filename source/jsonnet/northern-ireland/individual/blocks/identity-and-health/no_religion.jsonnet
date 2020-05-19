local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local nonProxyTitle = 'What religion, religious denomination or body were you <em>brought up</em> in?';
local proxyTitle = {
  text: 'What religion, religious denomination or body was {person_name} <em>brought up</em> in?',
  placeholders: [
    placeholders.personName,
  ],
};

local question(title, otherDescription) = {
  id: 'no-religion-question',
  title: title,
  type: 'MutuallyExclusive',
  mandatory: false,
  answers: [
    {
      id: 'no-religion-answer',
      mandatory: false,
      label: '',
      options: [
        {
          label: 'Roman Catholic',
          value: 'Roman Catholic',
        },
        {
          label: 'Presbyterian Church in Ireland',
          value: 'Presbyterian Church in Ireland',
        },
        {
          label: 'Church of Ireland',
          value: 'Church of Ireland',
        },
        {
          label: 'Methodist Church in Ireland',
          value: 'Methodist Church in Ireland',
        },
        {
          label: 'Other',
          value: 'Other',
          description: otherDescription,
        },
      ],
      type: 'Checkbox',
    },
    {
      id: 'no-religion-answer-exclusive',
      type: 'Checkbox',
      mandatory: false,
      options: [
        {
          label: 'None',
          value: 'None',
        },
      ],
    },
  ],
};

{
  type: 'Question',
  id: 'no-religion',
  question_variants: [
    {
      question: question(nonProxyTitle, 'You can enter your religion on the next question'),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, 'You can enter their religion on the next question'),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'no-religion-other',
        when: [
          {
            id: 'no-religion-answer',
            condition: 'contains',
            value: 'Other',
          },
        ],
      },
    },
    {
      goto: {
        block: 'health',
        when: [rules.under3],
      },
    },
    {
      goto: {
        block: 'health',
        when: [rules.lastBirthdayAgeLessThan(3)],
      },
    },
    {
      goto: {
        block: 'language',
      },
    },
  ],
}
