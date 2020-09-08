local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'other-national-identities-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'other-national-identities-answer',
      label: 'National identity',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: '{suggestions_api_url}/national-identities.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'other-national-identities',
  question_variants: [
    {
      question: question('You selected “Other”. How would you describe your other national identity?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Other”. How would <em>{person_name}</em> describe their other national identity?',
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
        block: 'ethnic-group',
      },
    },
  ],
}
