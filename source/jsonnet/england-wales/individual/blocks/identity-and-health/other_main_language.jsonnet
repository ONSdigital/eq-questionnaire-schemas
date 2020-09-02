local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'main-other-main-language-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'main-other-main-language-answer',
      label: 'Main language',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: {
        text: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v3.0.0/gb/{language_code}/languages.json',
        placeholders: [
          placeholders.languageCode,
        ],
      },
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'other-main-language',
  question_variants: [
    {
      question: question('You selected “Other, including British Sign Language”. What is your main language?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Other, including British Sign Language”. What is <em>{person_name_possessive}</em> main language?',
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
        block: 'level-of-spoken-english',
      },
    },
  ],
}
