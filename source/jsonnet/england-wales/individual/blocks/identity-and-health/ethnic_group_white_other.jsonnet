local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-white-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-white-other-answer',
      label: 'White ethnic group or background',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions: { url: '{suggestions_url_root}/ethnic-groups.json' },
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'ethnic-group-white-other',
  page_title: 'Other White ethnic group or background',
  question_variants: [
    {
      question: question('You selected “Any other White background”. How would you describe your White ethnic group or background?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Any other White background”. How would <em>{person_name}</em> describe their White ethnic group or background?',
        placeholders: [
          placeholders.personName(),
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
