local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, description) = {
  title: title,
  id: 'workplace-type-question',
  description: [
    description,
  ],
  type: 'General',
  answers: [
    {
      id: 'workplace-type-answer',
      mandatory: true,
      options: [
        {
          label: 'At a workplace',
          value: 'At a workplace',
        },
        {
          label: 'At or from home',
          value: 'At or from home',
        },
        {
          label: 'No fixed place',
          value: 'No fixed place',
        },
      ],
      type: 'Radio',
    },
  ],
};


local nonProxyTitleWork = 'Where do you mainly <em>work</em>?';
local proxyTitleWork = {
  text: 'Where does <em>{person_name}</em> mainly <em>work</em>?',
  placeholders: [
    placeholders.personName,
  ],
};
local nonProxyTitleDidWork = 'Where did you mainly <em>work</em>?';
local proxyTitleDidWork = {
  text: 'Where did <em>{person_name}</em> mainly <em>work</em>?',
  placeholders: [
    placeholders.personName,
  ],
};

local nonProxyDescriptionWork = 'Answer for the place where you spend the most time. Even if ill, on maternity leave, holiday or temporarily laid off provide details of your main place of work.';
local proxyDescriptionWork = {
  text: 'Answer for the place where <em>{person_name}</em> spends the most time. Even if ill, on maternity leave, holiday or temporarily laid off provide details of their main place of work.',
  placeholders: [
    placeholders.personName,
  ],
};

local nonProxyDescriptionDidWork = 'Answer for the place where you spent the most time.';
local proxyDescriptionDidWork = {
  text: 'Answer for the place where <em>{person_name}</em> spent the most time.',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'workplace-type',
  page_title: 'Type of workplace',
  question_variants: [
    {
      question: question(nonProxyTitleWork, nonProxyDescriptionWork),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitleWork, proxyDescriptionWork),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(nonProxyTitleDidWork, nonProxyDescriptionDidWork),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitleDidWork, proxyDescriptionDidWork),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'workplace-location',
        when: [
          {
            id: 'workplace-type-answer',
            condition: 'equals',
            value: 'At a workplace',
          },
        ],
      },
    },
    {
      goto: {
        block: 'travel-to-work',
        when: [
          {
            id: 'workplace-type-answer',
            condition: 'equals',
            value: 'No fixed place',
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
