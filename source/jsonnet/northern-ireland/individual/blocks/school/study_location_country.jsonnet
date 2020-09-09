local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'study-location-country-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'study-location-country-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      suggestions_url: '{suggestions_url_root}/countries-of-birth.json',
      mandatory: false,
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'study-location-country',
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
        block: 'travel-to-study-location',
      },
    },
  ],
}
