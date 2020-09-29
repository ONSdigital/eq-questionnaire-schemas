local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidanceHeader, guidanceContent) = {
  id: 'depot-address-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'depot-address-answer',
      mandatory: false,
      type: 'Address',
      lookup_options: {
        address_type: 'Workplace',
        region_code: std.extVar('region_code'),
      },
      guidance: {
        show_guidance: guidanceHeader,
        hide_guidance: guidanceHeader,
        contents: guidanceContent,
      },
    },
  ],
};

local nonProxyTitle = 'What is the address of your depot?';
local nonProxyGuidanceHeader = 'Why your answer is important';
local nonProxyGuidanceContent = [
  {
    description: 'Your answer will help your community by allowing the government and councils to understand commuting patterns.',
  },
  {
    description: 'Information about your workplace address and how you travel to work are used together to work out local public transport needs, develop transport policies and plan services.',
  },
];

local proxyTitle = {
  text: 'What is the address of <em>{person_name_possessive}</em> depot?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local proxyGuidanceHeader = 'Why their answer is important';
local proxyGuidanceContent = [
  {
    description: 'Their answer will help their community by allowing the government and councils to understand commuting patterns.',
  },
  {
    description: 'Information about their workplace address and how they travel to work are used together to work out local public transport needs, develop transport policies and plan services.',
  },
];

{
  type: 'Question',
  id: 'depot-address',
  page_title: 'Depot address',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyGuidanceHeader, nonProxyGuidanceContent),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyGuidanceHeader, proxyGuidanceContent),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        section: 'End',
      },
    },
  ],
}
