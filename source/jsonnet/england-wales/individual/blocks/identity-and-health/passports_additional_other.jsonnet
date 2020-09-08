local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title, guidance) = {
  id: 'passports-additional-other-question',
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
      id: 'passports-additional-other-answer',
      label: 'Passports',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: '{suggestions_api_url}/passport-countries.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'passports-additional-other',
  question_variants: [
    {
      question: question(
        'You selected “Other”. What other passports do you hold?',
        'Include all other passports. If you have more than one, enter them all separated by commas.'
      ),
      when: [rules.isNotProxy],
    },
    {
      question: question(
        {
          text: 'You selected “Other”. What other passports does <em>{person_name}</em> hold?',
          placeholders: [
            placeholders.personName,
          ],
        },
        'Include all other passports. If they have more than one, enter them all separated by commas.'
      ),
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
