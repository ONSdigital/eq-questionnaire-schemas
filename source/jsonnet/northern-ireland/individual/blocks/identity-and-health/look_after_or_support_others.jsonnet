local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidance) = {
  id: 'look-after-or-support-others-question',
  title: title,
  guidance: {
    contents: [
      {
        description: guidance,
      },
    ],
  },
  type: 'General',
  answers: [
    {
      id: 'look-after-or-support-others-answer',
      mandatory: false,
      options: [
        {
          label: 'No',
          value: 'No',
        },
        {
          label: 'Yes, 1-19 hours',
          value: 'Yes, 1-19 hours',
        },
        {
          label: 'Yes, 20 to 34 hours a week',
          value: 'Yes, 20 to 34 hours a week',
        },
        {
          label: 'Yes, 35 to 49 hours a week',
          value: 'Yes, 35 to 49 hours a week',
        },
        {
          label: 'Yes, 50 hours or more a week',
          value: 'Yes, 50 hours or more a week',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Do you look after, or give any help or support to, anyone because they have long-term physical or mental health conditions or illnesses, or problems related to old age?';
local nonProxyGuidance = 'Exclude anything you do in paid employment';
local proxyTitle = {
  text: 'Does <em>{person_name}</em> look after, or give any help or support to, anyone because they have long-term physical or mental health conditions or illnesses, or problems related to old age?',
  placeholders: [
    placeholders.personName(),
  ],
};
local proxyGuidance = 'Exclude anything they do in paid employment';

{
  type: 'Question',
  id: 'look-after-or-support-others',
  page_title: 'Look after or support others',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidance),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyGuidance),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'sexual-orientation',
        when: [rules.over16],
      },
    },
    {
      goto: {
        block: 'sexual-orientation',
        when: [rules.lastBirthdayAgeOver(16)],
      },
    },
    {
      goto: {
        group: 'school-group',
      },
    },
  ],
}
