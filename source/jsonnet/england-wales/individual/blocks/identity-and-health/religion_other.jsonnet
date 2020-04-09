local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'religion-other-question',
  title: title,
  guidance: {
    contents: [
      {
        description: 'This question is <strong>voluntary</strong>',
      },
    ],
  },
  type: 'General',
  answers: [
    {
      id: 'religion-other-answer',
      label: 'Religion',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      suggestions_url: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v1.0.0/religions.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'religion-other',
  question_variants: [
    {
      question: question('You selected “Any other religion”. What is your religion?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Any other religion”. What is <em>{person_name_possessive}</em> religion?',
        placeholders: [
          placeholders.personNamePossessive,
        ],
      }),
      when: [rules.isProxy],
    },
  ],
  routing_rules: [
    {
      goto: {
        block: 'passports',
        when: [
          rules.under3,
        ],
      },
    },
    {
      goto: {
        block: 'language',
      },
    },
  ],
}
