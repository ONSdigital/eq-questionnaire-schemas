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
      suggestions: { url: '{suggestions_url_root}/passport-countries.json', allow_multiple: true },
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'passports-additional-other',
  page_title: 'Other passports multiple',
  question_variants: [
    {
      question: question('You selected “Other”. What other passports do you hold?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Other”. What other passports does <em>{person_name}</em> hold?',
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
        block: 'national-identity',
      },
    },
  ],
}
