local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'passports-additional-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'passports-additional-other-answer',
      label: 'Passports',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v1.0.0/passport-countries.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'passports-additional-other',
  question_variants: [
    {
      question: question('You selected “Other”. What other passports do you hold?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected "Other". What other passports does <em>{person_name}</em> hold?',
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
        block: 'national-identity',
      },
    },
  ],
}
