local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-mixed-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-mixed-other-answer',
      label: 'Mixed or Multiple ethnic group or background',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'You selected “Any other Mixed or Multiple background”. How would your Mixed or Multiple ethnic group or background?';
local proxyTitle = {
  text: 'You selected “Any other Mixed or Multiple background”. How would {person_name} describe their Mixed or Multiple ethnic group or background?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'ethnic-group-mixed-other',
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
