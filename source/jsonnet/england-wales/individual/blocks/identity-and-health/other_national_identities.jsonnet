local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidance) = {
  id: 'other-national-identities-question',
  title: title,
  type: 'General',
  guidance: {
    contents: [
      {
        description: guidance,
      },
    ],
  },
  answers: [
    {
      id: 'other-national-identities-answer',
      label: 'National identity',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions: {
        url: '{suggestions_url_root}/national-identities.json',
        allow_multiple: true,
      },
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'other-national-identities',
  page_title: 'Other national identities',
  question_variants: [
    {
      question: question(
        'You selected “Other”. How would you describe your other national identity?',
        'Include all other national identities. If you have more than one, enter them all separated by commas.'
      ),
      when: [rules.isNotProxy],
    },
    {
      question: question(
        {
          text: 'You selected “Other”. How would <em>{person_name}</em> describe their other national identity?',
          placeholders: [
            placeholders.personName(),
          ],
        },
        'Include all other national identities. If they have more than one, enter them all separated by commas.'
      ),
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
