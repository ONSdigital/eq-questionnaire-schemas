local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'available-for-work-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'available-for-work-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes',
          value: 'Yes',
        },
        {
          label: 'No',
          value: 'No',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Are you available to start work in the next two weeks?';
local proxyTitle = {
  text: 'Is <em>{person_name}</em> available to start work in the next two weeks?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'available-for-work',
  question_variants: [
    {
      question: question(nonProxyTitle),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'ever-worked',
        when: [
          {
            id: 'available-for-work-answer',
            condition: 'equals',
            value: 'Yes',
          },
        ],
      },
    },
    {
      goto: {
        block: 'about-to-start-job',
      },
    },
  ],
}
