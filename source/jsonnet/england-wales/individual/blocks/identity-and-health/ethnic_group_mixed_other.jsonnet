local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'other-mixed-or-multiple-ethnic-group-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'other-mixed-or-multiple-ethnic-group-answer',
      label: 'Mixed or Multiple ethnic group or background',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'other-mixed-or-multiple-ethnic-group',
  question_variants: [
    {
      question: question('You selected “Any other Mixed or Multiple background”. How would you describe your Mixed or Multiple ethnic group or background?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Any other Mixed or Multiple background”. How would <em>{person_name}</em> describe their Mixed or Multiple ethnic group or background?',
        placeholders: [
          placeholders.personName,
        ],
      }),
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
