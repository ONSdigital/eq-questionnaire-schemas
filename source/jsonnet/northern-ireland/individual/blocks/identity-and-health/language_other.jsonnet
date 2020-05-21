local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'language-other-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'language-other-answer',
      label: 'Main language',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: 'https://cdn.eq.census-gcp.onsdigital.uk/data/v1.0.0/languages.json',
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'language-other',
  question_variants: [
    {
      question: question('You selected “Other, including British or Irish Sign Language”. What is your main language?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Other, including British or Irish Sign Language”. What is <em>{person_name_possessive}</em> main language?',
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
        block: 'english',
      },
    },
  ],
}
