local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'passports-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'passports-other-answer',
      label: 'Passports',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      suggestions_url: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v1.0.0/passport-countries.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'passports-other',
  question_variants: [
    {
      question: question('You selected “Other”. What passports do you hold?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Other”. What passports does <em>{person_name}</em> hold?',
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
        block: 'health',
      },
    },
  ],
}
