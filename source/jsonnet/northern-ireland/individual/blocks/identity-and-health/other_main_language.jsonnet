local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local listName = 'languages.json';

local suggestionsUrl = {
  text: '{suggestions_url}',
  placeholders: [placeholders.suggestionsUrl(listName)],
};

local question(title) = {
  id: 'other-main-language-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'other-main-language-answer',
      label: 'Main language',
      description: 'Enter your own answer or select from suggestions',
      max_length: 100,
      mandatory: false,
      suggestions_url: suggestionsUrl,
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'other-main-language',
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
        block: 'level-of-spoken-english',
      },
    },
  ],
}
