local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-other-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-other-other-answer',
      label: 'Ethnic group',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'You selected “Any other ethnic group”. How would you describe your ethnic group or background?';
local proxyTitle = {
  text: 'You selected “Any other ethnic group”. How would <em>{person_name}</em> describe their ethnic group or background?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'ethnic-group-other-other',
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
        block: 'religion',
      },
    },
  ],
}
