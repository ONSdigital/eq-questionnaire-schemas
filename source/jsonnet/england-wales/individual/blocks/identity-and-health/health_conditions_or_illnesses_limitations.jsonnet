local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, definition) = {
  id: 'health-conditions-or-illnesses-limitations-question',
  title: title,
  definitions: [definition],
  type: 'General',
  answers: [
    {
      id: 'health-conditions-or-illnesses-limitations-answer',
      mandatory: false,
      options: [
        {
          label: 'Yes, a lot',
          value: 'Yes, a lot',
        },
        {
          label: 'Yes, a little',
          value: 'Yes, a little',
        },
        {
          label: 'Not at all',
          value: 'Not at all',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Do any of your conditions or illnesses reduce your ability to carry out day-to-day activities?';
local nonProxyDefinition = {
  title: 'What we mean by “reduce your ability”',
  contents: [
    {
      description: 'This is about whether your health condition or illness currently affects your ability to carry out day-to-day activities.',
    },
    {
      description: 'Consider whether you are still affected while receiving any treatment, medication or using any devices for your condition or illness. For example, if you use a hearing aid and are not restricted in carrying out your day-to-day activities when doing so, select “Not at all”.',
    },
    {
      description: 'You should select “Yes, a lot” if you usually need some level of support from family members, friends or personal social services for most normal daily activities.',
    },
  ],
};
local proxyTitle = {
  text: 'Do any of <em>{person_name_possessive}</em> conditions or illnesses reduce their ability to carry out day-to-day activities?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local proxyDefinition = {
  title: 'What we mean by “reduce their ability”',
  contents: [
    {
      description: 'This is about whether their health condition or illness currently affects their ability to carry out day-to-day activities.',
    },
    {
      description: 'Consider whether they are still affected while receiving any treatment, medication or using any devices for their condition or illness. For example, if they use a hearing aid and are not restricted in carrying out their day-to-day activities when doing so, select “Not at all”.',
    },
    {
      description: 'You should select “Yes, a lot” if they usually need some level of support from family members, friends or personal social services for most normal daily activities.',
    },
  ],
};

{
  type: 'Question',
  id: 'health-conditions-or-illnesses-limitations',
  page_title: 'Health conditions or illnesses that reduce activity',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyDefinition),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyDefinition),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        section: 'End',
        when: [
          rules.under5,
        ],
      },
    },
    {
      goto: {
        block: 'look-after-or-support-others',
      },
    },
  ],
}
