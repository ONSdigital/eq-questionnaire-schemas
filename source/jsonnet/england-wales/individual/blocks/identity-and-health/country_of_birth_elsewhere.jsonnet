local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'country-of-birth-elsewhere-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'country-of-birth-elsewhere-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'country-of-birth-elsewhere',
  question_variants: [
    {
      question: question('You selected “Elsewhere”. What is your country of birth?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'You selected “Elsewhere”. What is <em>{person_name_possessive}</em> country of birth?',
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
        block: 'arrive-in-country',
      },
    },
  ],
}
