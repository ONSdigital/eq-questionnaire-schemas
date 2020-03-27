local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-black-african-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-black-african-answer',
      label: 'African ethnic group or background',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'You selected “African”. How would you describe your African ethnic group or background?';
local proxyTitle = {
  text: 'You selected “African”. How would {person_name} describe their African ethnic group or background?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'ethnic-group-black-african',
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
