local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'workplace-address-question',
  type: 'General',
  title: title,
  answers: [
    {
      id: 'workplace-address-answer',
      mandatory: true,
      type: 'Address',
      lookup_options: {
        address_type: 'Workplace',
        region_code: std.extVar('region_code'),
      },
    },
  ],
};

local nonProxyTitleWork = 'What is the address of your main place of <em>work</em>?';
local proxyTitleWork = {
  text: 'What is the address of <em>{person_name_possessive}</em> main place of <em>work</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};

local pastNonProxyTitleWork = 'What was the address of your main place of <em>work</em>?';
local pastProxyTitleWork = {
  text: 'What was the address of <em>{person_name_possessive}</em> main place of <em>work</em>?',
  placeholders: [
    placeholders.personNamePossessive,
  ],
};


{
  type: 'Question',
  id: 'workplace-address',
  page_title: 'Workplace address',
  question_variants: [
    {
      question: question(nonProxyTitleWork),
      when: [rules.isNotProxy, rules.mainJob],
    },
    {
      question: question(proxyTitleWork),
      when: [rules.isProxy, rules.mainJob],
    },
    {
      question: question(pastNonProxyTitleWork),
      when: [rules.isNotProxy],
    },
    {
      question: question(pastProxyTitleWork),
      when: [rules.isProxy],
    },
  ],
}
