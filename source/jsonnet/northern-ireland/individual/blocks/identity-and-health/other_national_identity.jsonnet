local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'other-national-identity-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'other-national-identity-answer',
      label: 'National identity',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v2.0.0/ni/national-identities.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'other-national-identity',
  page_title: 'Other national identity',
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
