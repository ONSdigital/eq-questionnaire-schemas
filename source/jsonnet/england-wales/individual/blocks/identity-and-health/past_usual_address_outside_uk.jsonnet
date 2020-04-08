local placeholders = import '../../../lib/placeholders.libsonnet';
local rules = import 'rules.libsonnet';

local question(title) = {
  id: 'past-usual-address-outside-uk-question',
  title: title,
  type: 'General',
  answers: [
    {
      id: 'past-usual-address-outside-uk-answer',
      label: 'Current name of country',
      description: 'Enter your own answer or select from suggestions',
      mandatory: false,
      suggestions_url: "https://cdn.eq.census-gcp.onsdigital.uk/data/v1.0.0/countries-of-birth.json",
      type: 'TextField',
    },
  ],
};

{
  type: 'Question',
  id: 'past-usual-address-outside-uk',
  question_variants: [
    {
      question: question('In which country outside the UK was your usual address one year ago?'),
      when: [rules.isNotProxy],
    },
    {
      question: question({
        text: 'In which country outside of the UK was <em>{person_name_possessive}</em> usual address one year ago?',
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
        block: 'national-identity',
      },
    },
  ],
}
