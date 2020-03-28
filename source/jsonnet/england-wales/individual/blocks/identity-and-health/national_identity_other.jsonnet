local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'national-identity-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'national-identity-other-answer',
      label: 'National identity',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'national-identity-other',
  question_variants: [
    {
      question: question('You selected “Other”. How would you describe your national identity?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Other”. How would <em>{person_name}</em> describe their national identity?',
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
