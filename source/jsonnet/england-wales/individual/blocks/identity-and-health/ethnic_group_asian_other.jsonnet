local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-asian-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-asian-other-answer',
      label: 'Asian or Asian British ethnic group or background',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'You selected "Any other Asian background". How would you describe your Asian or Asian British ethnic group or background?';
local proxyTitle = {
  text: 'You selected "Any other Asian background". How would {name} describe their Asian or Asian British ethnic group or background?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'ethnic-group-asian-other',
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
