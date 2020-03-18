local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidanceHeader, guidanceDescription) = {
  id: 'employer-address-workplace-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'employer-address-workplace-answer-building',
      label: 'Address line 1',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'employer-address-workplace-answer-street',
      label: 'Address line 2',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'employer-address-workplace-answer-city',
      label: 'Town or city',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'employer-address-workplace-answer-county',
      label: 'County',
      mandatory: false,
      type: 'TextField',
    },
    {
      id: 'employer-address-workplace-answer-postcode',
      label: 'Postcode',
      mandatory: false,
      type: 'TextField',
      guidance: {
        show_guidance: guidanceHeader,
        hide_guidance: guidanceHeader,
        contents: [
          {
            description: guidanceDescription,
          },
        ],
      },
    },
  ],
};

local nonProxyTitle = 'What is the address of your workplace?';
local nonProxyguidanceHeader = 'Why your answer is important';
local nonProxyGuidanceDescription = 'Your answer will help your community by allowing the government and councils to understand commuting patterns.<br><br>Information about your workplace address and how you travel to work are used together to work out local public transport needs, develop transport policies and plan services.';

local proxyTitle = {
  text: 'What is the address of <em>{person_name_possessive}</em> workplace?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};
local proxyguidanceHeader = 'Why their answer is important';
local proxyGuidanceDescription = 'Their answer will help their community by allowing the government and councils to understand commuting patterns.<br><br>Information about their workplace address and how they travel to work are used together to work out local public transport needs, develop transport policies and plan services.';


{
  type: 'Question',
  id: 'employer-address-workplace',
  question_variants: [
    {
      question: question(nonProxyTitle, nonProxyguidanceHeader, nonProxyGuidanceDescription),
      when: [rules.isNotProxy],
    },
    {
      question: question(proxyTitle, proxyguidanceHeader, proxyGuidanceDescription),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        group: 'submit-group',
      },
    },
  ],
}
