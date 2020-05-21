local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'ethnic-group-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'ethnic-group-other-answer',
      label: 'Ethnic group',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v1.0.0/ethnic-groups.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'ethnic-group-other',
  question_variants: [
    {
      question: question('You selected “Any other ethnic group”. How would you describe your ethnic group or background?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Any other ethnic group”. How would <em>{person_name}</em> describe their ethnic group or background?',
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
