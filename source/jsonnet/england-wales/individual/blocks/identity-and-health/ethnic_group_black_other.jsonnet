local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-black-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-black-other-answer',
      label: 'Black, Black British or Caribbean background',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

local nonProxyTitle = 'You selected “Any other Black, Black British or Caribbean background”. How would you describe your Black, Black British or Caribbean ethnic group or background?';
local proxyTitle = {
  text: 'You selected “Any other Black, Black British or Caribbean background”. How would {person_name} describe their Black, Black British or Caribbean ethnic group or background?',
  placeholders: [
    placeholders.personName,
  ],
};

{
  type: 'Question',
  id: 'ethnic-group-black-other',
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
