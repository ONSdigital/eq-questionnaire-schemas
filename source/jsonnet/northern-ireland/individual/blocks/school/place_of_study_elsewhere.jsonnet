local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'place-of-study-elsewhere-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'place-of-study-elsewhere-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'place-of-study-elsewhere',
  question_variants: [
    {
      question: question('In which country is your course of <em>study</em>, including school?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'In which country is <em>{person_name_possessive}</em> course of <em>study</em>, including school?',
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
        block: 'school-travel',
      },
    },
  ],
}
