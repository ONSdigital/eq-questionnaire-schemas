local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'no-religion-other-question',
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
      id: 'no-religion-other-answer',
      label: 'Religion',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v1.0.0/religions.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'no-religion-other',
  question_variants: [
    {
      question: question('You selected “Other”. What religion, religious denomination were you brought up in?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Other”. What religion, religious denomination or body was <em>{person_name_possessive}</em> brought up in?',
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
        block: 'health',
        when: [
          rules.under3,
        ],
      },
    },
    {
      goto: {
        block: 'health',
        when: [rules.lastBirthdayAgeLessThan(3)],
      },
    },
    {
      goto: {
        block: 'main-language',
      },
    },
  ],
}
