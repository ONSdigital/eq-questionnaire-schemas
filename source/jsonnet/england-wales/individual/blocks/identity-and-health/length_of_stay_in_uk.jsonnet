local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'length-of-stay-in-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'length-of-stay-in-uk-answer',
      mandatory: false,
      options: [
        {
          label: 'Less than 12 months',
          value: 'Less than 12 months',
        },
        {
          label: '12 months or more',
          value: '12 months or more',
        },
      ],
      type: 'Radio',
    },
  ],
};

local nonProxyTitle = 'Including the time already spent here, how long do you intend to stay in the United Kingdom?';

local proxyTitle = {
  text: 'Including the time already spent here, how long does <em>{person_name}</em> intend to stay in the United Kingdom?',
  placeholders: [
    placeholders.personName(),
  ],
};

{
  type: 'Question',
  id: 'length-of-stay-in-uk',
  page_title: 'Planned length of stay in the UK',
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
        block: 'national-identity',
        when: [
          rules.under1,
        ],
      },
    },
    {
      goto: {
        block: 'location-one-year-ago',
      },
    },
  ],
}
